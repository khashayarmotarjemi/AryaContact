import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:maps_test/map/map_bloc.dart';
import 'package:maps_test/map/map_provider.dart';
import 'package:maps_test/postal/postal_bloc.dart';
import 'package:rxdart/rxdart.dart';

class MapView extends StatelessWidget {
  MapView({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    MapBloc bloc = MapBlocProvider.of(context);

    return StreamBuilder<MergedMapData>(
        stream: mergeMapData(bloc.markerLocation, bloc.clickable),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return new FlutterMap(
              options: new MapOptions(
                onPositionChanged: (mapPosition) {
                  bloc.setViewPoint.add(mapPosition.center);
                },
                onTap: (latlng) {
                  bloc.setMarker.add(latlng);
                },
                center: new LatLng(36.6830, 48.5087),
                zoom: 12.0,
              ),
              layers: [
                new TileLayerOptions(
                  urlTemplate: "https://api.tiles.mapbox.com/v4/"
                      "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
                  additionalOptions: {
                    'accessToken':
                        'pk.eyJ1Ijoia2hhc2hheWFybW90YXJqZW1pIiwiYSI6ImNqb3d1NWRx'
                        'eTFscDMzcG85aGxpcTM3YmMifQ.LUFyMRYSzoYWbrNlyHb_yQ',
                    'id': 'mapbox.streets',
                  },
                ),
                new MarkerLayerOptions(markers: [
                  new Marker(
                      point: snapshot.data.marker,
                      builder: (context) => Icon(Icons.place),width: 110,height: 110)
                ])
              ],
            );
          } else {
            return new Text("no data");
          }
        });
  }

  void _setViewpoint(LatLng viewPoint, BuildContext context) {
    MapBlocProvider.of(context).setViewPoint.add(viewPoint);
  }

  static Stream<MergedMapData> mergeMapData(
      Stream<LatLng> markerLocation, Stream<bool> clickable) {
    return Observable.combineLatest2(markerLocation, clickable,
        (markerLoc, clickable) => new MergedMapData(markerLoc, clickable));
  }
}

class MergedMapData {
  final LatLng marker;
  final bool clickable;

  MergedMapData(this.marker, this.clickable);
}
