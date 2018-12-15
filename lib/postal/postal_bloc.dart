import 'dart:async';

import 'package:latlong/latlong.dart';
import 'package:rxdart/rxdart.dart';

class PostalBloc {
  // Inputs
  Sink<LatLng> setLocation;

  // Outputs
  Stream<PostalData> postalData;

  final List<StreamSubscription<dynamic>> _subscriptions;

  factory PostalBloc(PostalRepository repository) {
    final postalDataController = BehaviorSubject<PostalData>(seedValue: null);

    final setLocationController = StreamController<LatLng>(sync: true);

    final subscriptions = <StreamSubscription<dynamic>>[
      setLocationController.stream.listen((location) {
        Observable.fromFuture(repository.getPostalData(location))
            .pipe(postalDataController);
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

class PostalData {
  final String postalCode;

  PostalData(this.postalCode);
}

abstract class PostalRepository {
  Future<PostalData> getPostalData(LatLng location);
}
