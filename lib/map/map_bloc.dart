import 'dart:async';

import 'package:latlong/latlong.dart';
import 'package:quiver/core.dart';
import 'package:rxdart/rxdart.dart';

class MapBloc {
  // inputs
  final Sink<LatLng> setLocation;
  final Sink<void> unsetLocation;
  final Sink<LatLng> setViewPoint;
  final Sink<LatLng> setCenter;
  final Sink<bool> setClickable;
  final Sink<bool> setShowCenterPointer;
  final Sink<void> reset;
  final Sink<double> setZoom;

  // outputs
  final Stream<LatLng> location;
  final Stream<LatLng> viewPoint;
  final Stream<LatLng> center;
  final Stream<bool> clickable;
  final Stream<bool> showCenterPointer;
  final Stream<double> zoom;

  //
  LatLng mapCenter = UnassignedLocation();

  final List<StreamSubscription<dynamic>> _subscriptions;

  factory MapBloc(LatLng initViewpoint) {
    final setLocationController = StreamController<LatLng>(sync: true);
    final unsetLocationController = StreamController<void>(sync: true);
    final setViewPointController = StreamController<LatLng>(sync: true);
    final setClickableController = StreamController<bool>(sync: true);
    final setShowCenterPointerController = StreamController<bool>(sync: true);
    final setCenterController = StreamController<LatLng>(sync: true);
    final resetController = StreamController<void>(sync: true);
    final setZoomController = StreamController<double>(sync: true);

    final locationController = BehaviorSubject<LatLng>(sync: true);
    final viewPointController =
        BehaviorSubject<LatLng>(seedValue: initViewpoint, sync: true);
    final clickableController =
        BehaviorSubject<bool>(seedValue: true, sync: true);
    final showCenterPointerController =
        BehaviorSubject<bool>(seedValue: true, sync: true);

    final centerController =
        BehaviorSubject<LatLng>(seedValue: UnassignedLocation(), sync: true);

    final zoomController = BehaviorSubject<double>(seedValue: 13, sync: true);

    final subscriptions = <StreamSubscription<dynamic>>[
      setLocationController.stream.listen((location) {
        locationController.sink.add(location);
        if (!(location is UnassignedLocation)) {
          setShowCenterPointerController.sink.add(false);
          setClickableController.sink.add(false);
        }
      }),
      unsetLocationController.stream.listen((_) {
        locationController.sink.add(UnassignedLocation());
      }),
      Observable(setViewPointController.stream)
          .debounce(Duration(seconds: 2))
          .listen(viewPointController.sink.add),
      setClickableController.stream.listen(clickableController.sink.add),
      setShowCenterPointerController.stream
          .listen(showCenterPointerController.sink.add),
      setCenterController.stream.listen(centerController.sink.add),
      resetController.stream.listen((_) {
        setClickableController.sink.add(true);
        setShowCenterPointerController.sink.add(true);
        unsetLocationController.sink.add(UnassignedLocation());
      }),
      setZoomController.stream.listen(zoomController.sink.add),
    ];

    return MapBloc._(
        setLocationController,
        unsetLocationController,
        setViewPointController,
        setClickableController,
        resetController,
        setZoomController,
        locationController,
        viewPointController.stream,
        clickableController,
        setShowCenterPointerController,
        showCenterPointerController,
        setCenterController,
        centerController,
        zoomController,
        subscriptions);
  }

  MapBloc._(
      this.setLocation,
      this.unsetLocation,
      this.setViewPoint,
      this.setClickable,
      this.reset,
      this.setZoom,
      this.location,
      this.viewPoint,
      this.clickable,
      this.setShowCenterPointer,
      this.showCenterPointer,
      this.setCenter,
      this.center,
      this.zoom,
      this._subscriptions);

  void close() {
    setLocation.close();
    unsetLocation.close();
    setViewPoint.close();
    setClickable.close();
    setShowCenterPointer.close();
    setCenter.close();
    setZoom.close();
    _subscriptions.clear();
  }
}

class UnassignedLocation extends LatLng {
  UnassignedLocation() : super(1, 1);

  @override
  bool operator ==(final Object other) {
    return other is UnassignedLocation;
  }

  @override
  int get hashCode {
    return hash2(LatLng(1,1),1);
  }


}
