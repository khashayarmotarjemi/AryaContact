import 'dart:async';

import 'package:arya_contact/search/address_search_repository.dart';
import 'package:rxdart/rxdart.dart';

class AddressSearchBloc {
  // Inputs
  Sink<String> search;
  Sink<SearchResult> select;
  Sink<bool> setResultVisibility;

  // Outputs
  Stream<SearchResult> latestSelected;
  Stream<List<SearchResult>> locations;
  Stream<bool> resultVisibility;

  final List<StreamSubscription<dynamic>> _subscriptions;

  factory AddressSearchBloc(AddressSearchRepository repository) {
    final locationsController = PublishSubject<List<SearchResult>>(
      sync: true, /* seedValue: <SearchResult>[]*/
    );

    final searchController = StreamController<String>(sync: true);

    final selectedController = BehaviorSubject<SearchResult>(
        seedValue: EmptySearchResult(), sync: true);

    final resultVisibilityController =
        BehaviorSubject<bool>(seedValue: false, sync: true);

    final subscriptions = <StreamSubscription<dynamic>>[
      searchController.stream.listen((searchString) {
        repository
            .getSearchLocations(searchString)
            .then(locationsController.sink.add);
      })
    ];

    return AddressSearchBloc._(
        locationsController,
        searchController,
        selectedController,
        selectedController.stream,
        resultVisibilityController,
        resultVisibilityController.stream,
        subscriptions);
  }

  AddressSearchBloc._(
      this.locations,
      this.search,
      this.select,
      this.latestSelected,
      this.setResultVisibility,
      this.resultVisibility,
      this._subscriptions);

  void close() {
    search.close();
    select.close();
    setResultVisibility.close();
    _subscriptions.clear();
  }
}
