import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';

class PostalInfoFinderBloc {
  // input
  final Sink<Location> updateLocation;

  // output
  final Stream<PostalInfo> postalInfo;

  factory PostalInfoFinderBloc() {
    final locationUpdateController = BehaviorSubject<Location>();
    final postalInfoController = BehaviorSubject<PostalInfo>();

    locationUpdateController.listen((location) async {
      PostalInfo pi;
      switch (location.goeLocation.latitude) {
        case 1:
          pi = PostalInfo("1111");
          break;

        case 2:
          pi = PostalInfo("2222");

          break;

        case 3:
          pi = PostalInfo("3333");

          break;
      }

      new Observable(new Stream.fromIterable([pi]))
          .pipe(postalInfoController);
    });

    return PostalInfoFinderBloc._(
        locationUpdateController, postalInfoController);
  }

  PostalInfoFinderBloc._(this.updateLocation, this.postalInfo);

  void close() {

  }
}

class Location {
  final LatLng goeLocation;

  const Location(this.goeLocation);
}

class PostalInfo {
  final String postalCode;

  PostalInfo(this.postalCode);
}