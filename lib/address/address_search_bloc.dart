import 'dart:async';

import 'package:arya_contact/address/address_search_repository.dart';
import 'package:rxdart/rxdart.dart';

class AddressSearchBloc {
  // Inputs
  Sink<String> search;

  // Outputs
  Stream<List<SearchLocation>> locations;

  final List<StreamSubscription<dynamic>> _subscriptions;

  factory AddressSearchBloc(AddressSearchRepository repository) {
    final locationsController = BehaviorSubject<List<SearchLocation>>(
      sync: true,
    );

    final searchController = StreamController<String>(sync: true);

    final subscriptions = <StreamSubscription<dynamic>>[
      searchController.stream.listen((searchString) {
        repository
            .getSearchLocations(searchString)
            .then(locationsController.sink.add);
      })
    ];

    return AddressSearchBloc._(
        locationsController, searchController, subscriptions);
  }

  AddressSearchBloc._(this.locations, this.search, this._subscriptions);

  void close() {
    search.close();
    _subscriptions.clear();
  }
}
