import 'dart:async';

import 'package:arya_contact/postal/postal_data.dart';
import 'package:arya_contact/postal/postal_repository.dart';
import 'package:latlong/latlong.dart';
import 'package:rxdart/rxdart.dart';

class PostalBloc {
  // Inputs
  Sink<LatLng> setLocation;

  // Outputs
  Stream<PostalData> postalData;

  final List<StreamSubscription<dynamic>> _subscriptions;

  factory PostalBloc(PostalRepository repository) {
    final postalDataController =
    BehaviorSubject<PostalData>(sync: true, seedValue: EmptyPostalData());

    final setLocationController = StreamController<LatLng>(sync: true);

    final subscriptions = <StreamSubscription<dynamic>>[
      setLocationController.stream.listen((location) {
        repository.getPostalData(location).asStream().listen((postalData) {
          print(postalData);
          postalDataController.sink.add(postalData);
        });
      })
    ];

    return PostalBloc._(
        postalDataController, setLocationController, subscriptions);
  }

  PostalBloc._(this.postalData, this.setLocation, this._subscriptions);

  void close() {
    setLocation.close();
    _subscriptions.clear();
  }
}
