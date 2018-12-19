import 'dart:async';

import 'package:arya_contact/map/map_bloc.dart';
import 'package:arya_contact/postal/postal_data.dart';
import 'package:latlong/latlong.dart';
import 'package:rxdart/rxdart.dart';

class AppBloc {
  // inputs
  final Sink<LatLng> setLocation;
  final Sink<PostalData> setPostal;

  // outputs
  final Stream<LatLng> location;
  final Stream<PostalData> postal;

  final List<StreamSubscription<dynamic>> _subscriptions;

  factory AppBloc() {
    final setLocationController = StreamController<LatLng>(sync: true);
    final setPostalController = StreamController<PostalData>(sync: true);

    final locationController =
        BehaviorSubject<LatLng>(seedValue: UnassignedLocation(), sync: true);
    final postalController =
        BehaviorSubject<PostalData>(seedValue: EmptyPostalData(), sync: true);

    final subscriptions = <StreamSubscription<dynamic>>[
      setLocationController.stream.listen(locationController.sink.add),
      setPostalController.stream.listen(postalController.sink.add),
    ];

    return AppBloc._(setLocationController, locationController,
        setPostalController, postalController, subscriptions);
  }

  AppBloc._(this.setLocation, this.location, this.setPostal, this.postal,
      this._subscriptions);

  void close() {
    setPostal.close();
    setLocation.close();
    _subscriptions.clear();
  }
}
