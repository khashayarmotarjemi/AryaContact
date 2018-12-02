import 'dart:io';

import 'package:test_api/test_api.dart';
import 'data';

void main() {
  group('postal info bloc', () {
    test("should work!", () {
      final PostalInfoFinderBloc bloc = new PostalInfoFinderBloc();

      bloc.postalInfo.listen((postalData) {
        print(postalData.postalCode);
      });

      bloc.updateLocation.add(Location(new LatLng(2, 0)));
      sleep(new Duration(seconds: 1));
      bloc.updateLocation.add(Location(new LatLng(3, 0)));
    });
  });
}
