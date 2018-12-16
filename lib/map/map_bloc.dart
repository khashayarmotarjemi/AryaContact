import 'dart:async';

import 'package:latlong/latlong.dart';
import 'package:rxdart/rxdart.dart';

class MapBloc {
  // inputs
  final Sink<LatLng> setMarker;
  final Sink<void> unsetMarker;
  final Sink<LatLng> setViewPoint;
  final Sink<bool> setClickable;
  final Sink<bool> setShowCenterPointer;

  // outputs
  final Stream<LatLng> markerLocation;
  final Stream<LatLng> viewPoint;
  final Stream<bool> clickable;
  final Stream<bool> showCenterPointer;

  final List<StreamSubscription<dynamic>> _subscriptions;

  factory MapBloc(LatLng initViewpoint) {
    final setMarkerController = StreamController<LatLng>(sync: true);
    final unsetLocationController = StreamController<void>(sync: true);
    final setViewPointController = StreamController<LatLng>(sync: true);
    final setClickableController = StreamController<bool>(sync: true);
    final setShowCenterPointerController = StreamController<bool>(sync: true);

    final markerLocationController =
    BehaviorSubject<LatLng>(seedValue: LatLng(22, 22));
    final viewPointController =
    BehaviorSubject<LatLng>(seedValue: initViewpoint);
    final clickableController = BehaviorSubject<bool>(
        seedValue: true, sync: true);
    final showCenterPointerController = BehaviorSubject<bool>(
        seedValue: true, sync: true);

    final subscriptions = <StreamSubscription<dynamic>>[
      setMarkerController.stream.listen(markerLocationController.sink.add),
      unsetLocationController.stream.listen((_) {
        markerLocationController.sink.add(null);
      }),
      setViewPointController.stream.listen(viewPointController.sink.add),
      setClickableController.stream.listen(clickableController.sink.add),
      setShowCenterPointerController.stream.listen(showCenterPointerController.sink.add)
    ];

    return MapBloc._(
        setMarkerController,
        unsetLocationController,
        setViewPointController,
        setClickableController,
        markerLocationController,
        viewPointController,
        clickableController,
        setShowCenterPointerController,
        showCenterPointerController,
        subscriptions);
  }

  MapBloc._(this.setMarker,
      this.unsetMarker,
      this.setViewPoint,
      this.setClickable,
      this.markerLocation,
      this.viewPoint,
      this.clickable,
      this.setShowCenterPointer,
      this.showCenterPointer,
      this._subscriptions);

  void close() {
    setMarker.close();
    unsetMarker.close();
    setViewPoint.close();
    setClickable.close();
    setShowCenterPointer.close();
    _subscriptions.clear();
  }
}
