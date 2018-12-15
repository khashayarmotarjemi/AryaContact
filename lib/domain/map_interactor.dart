import 'package:latlong/latlong.dart';
import 'package:rxdart/rxdart.dart';

class MapInteractor {
  LatLng _viewPoint;
  LatLng _selectedLocation;
  bool _clickable = true;

/*
  set viewPoint(LatLng value) {
    _viewPoint = value;
  }

  LatLng get selectedLocation => _selectedLocation;

  set selectedLocation(LatLng value) {
    _selectedLocation = value;
  }

  bool get clickable => _clickable;

  set clickable(bool value) {
    _clickable = value;
  }*/

  Future<LatLng> selectedLocation() async {
    return _selectedLocation;
  }

/*  Future<LatLng> viewPoint() async {
    return _viewPoint;
  }*/

  Stream<LatLng> viewPoint() {
    return Observable.fromIterable([_viewPoint]);
  }


  Future<bool> clickable() async {
    return _clickable;
  }

  Future setClickable(bool clickable) {
    _clickable = clickable;
  }

  Future setLocation(LatLng location) async {
    _selectedLocation = location;
  }

  Future unsetLocation(void _) async {
    _selectedLocation = null;
  }

  Sink<LatLng> setViewPoint(LatLng viewPoint) {
    _viewPoint = viewPoint;
/*
    print(_viewPoint);
*/
  }
}
