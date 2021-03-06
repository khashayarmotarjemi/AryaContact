import 'package:latlong/latlong.dart';
import 'package:arya_contact/map/map_bloc.dart';
import 'package:arya_contact/map/map_view.dart';
import 'package:arya_contact/postal/postal_bloc.dart';
import 'package:test_api/test_api.dart';

void main() {
  group('map bloc', () {
    MapBloc bloc = new MapBloc(LatLng(25, 35));

    test("viewPoint test", () {
      bloc.setViewPoint.add(new LatLng(25, 20));
      bloc.setViewPoint.add(new LatLng(13, 2));
      bloc.setViewPoint.add(new LatLng(24, 45));

      bloc.viewPoint.listen((loc) {
        expect(loc.latitude, 24);
      });
    });

    test("clickable test", () {
      bloc.clickable.listen((clickable) {
        expect(clickable, true);
      });

      bloc.setClickable.add(true);
    });

    test("marker test", () {
      bloc.location.listen((loc) {
        print(loc);
      });

      bloc.setLocation.add(LatLng(60, 70));
      bloc.setLocation.add(LatLng(65, 75));
      bloc.unsetLocation.add(LatLng);
    });

    test("Merged map data test", () {
      MapView.mergeMapData(bloc)
          .listen((data) {
        print(data.clickable);
      });

      bloc.setClickable.add(false);
          });
  });
  return;
}
