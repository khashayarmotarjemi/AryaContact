import 'dart:async';

import 'package:arya_contact/contact/contact_bloc_provider.dart';
import 'package:arya_contact/map/map_bloc.dart';
import 'package:arya_contact/map/map_provider.dart';
import 'package:arya_contact/postal/postal_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:rxdart/rxdart.dart';

class MapView extends StatelessWidget {
  MapView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MapBloc bloc = MapBlocProvider.of(context);

    return StreamBuilder<MergedMapData>(
        stream: mergeMapData(bloc),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(children: <Widget>[
              new FlutterMap(
                options: new MapOptions(
                  onPositionChanged: (mapPosition) {
                    bloc.setViewPoint.add(mapPosition.center);
                  },
                  center: snapshot.data.viewPoint,
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
                  /*new MarkerLayerOptions(markers: [
                    new Marker(
                        point: snapshot.data.marker,
                        builder: (context) => Icon(
                              Icons.place,
                              size: 78,
                            ))
                  ])*/
                ],
              ),
              !snapshot.data.clickable
                  ? new Container(color: Color.fromARGB(0, 255, 240, 240))
                  : Container(),
              snapshot.data.clickable
                  ? StreamBuilder<bool>(
                      stream: bloc.showCenterPointer,
                      builder: (context, showCenterPointerSnapshot) {
                        if (showCenterPointerSnapshot.hasData) {
                          return showCenterPointerSnapshot.data
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Card(
                                      child: Text("اینجا"),
                                    ),
                                    new Container(
                                      alignment: Alignment.center,
                                      child: IconButton(
                                          icon: Icon(
                                            Icons.place,
                                            color: Colors.red,
                                          ),
                                          iconSize: 78,
                                          onPressed: () {
                                            bloc.viewPoint.first.then((latLng) {
                                              bloc.setMarker.add(latLng);
                                              bloc.setShowCenterPointer
                                                  .add(false);
                                              ContactsBlocProvider.of(context)
                                                  .setPostal
                                                  .add(PostalData("12"));
                                            });
                                          }),
                                    ),
                                  ],
                                )
                              : Container();
                        } else {
                          return Container();
                        }
                      },
                    )
                  : Container()
            ]);
          } else {
            return new Text("no data");
          }
        });
  }

  static Stream<MergedMapData> mergeMapData(MapBloc bloc) {
    return Observable.combineLatest3(
        bloc.markerLocation,
        bloc.clickable,
        bloc.viewPoint,
        (markerLoc, clickable, viewPoint) =>
            new MergedMapData(markerLoc, clickable, viewPoint));
  }
}

class MergedMapData {
  final LatLng marker;
  final bool clickable;
  final LatLng viewPoint;

  MergedMapData(this.marker, this.clickable, this.viewPoint);
}
