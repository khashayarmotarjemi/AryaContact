//import 'dart:async';
//
//import 'package:latlong/latlong.dart';
//import 'package:arya_contact/postal/postal_data.dart';
//import 'package:arya_contact/postal/postal_repository.dart';
//import 'package:rxdart/rxdart.dart';
//
//class DeviceLocationBloc {
//  // Inputs
//  Sink<LatLng> setLocation;
//
//  // Outputs
//  Stream<DeviceLocationData> postalData;
//
//  final List<StreamSubscription<dynamic>> _subscriptions;
//
//  factory DeviceLocationBloc(DeviceLocationRepository repository) {
//    final postalDataController = BehaviorSubject<DeviceLocationData>(seedValue: null);
//
//    final setLocationController = StreamController<LatLng>(sync: true);
//
//    final subscriptions = <StreamSubscription<dynamic>>[
//      setLocationController.stream.listen((location) {
//        Observable.fromFuture(repository.getDeviceLocationData(location))
//            .pipe(postalDataController);
//      })
//    ];
//
//    return DeviceLocationBloc._(
//        postalDataController, setLocationController, subscriptions);
//  }
//
//  DeviceLocationBloc._(this.postalData, this.setLocation, this._subscriptions);
//
//  void close() {
//    setLocation.close();
//    _subscriptions.clear();
//  }
//}
//
