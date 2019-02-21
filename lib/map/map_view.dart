import 'dart:async';

import 'package:arya_contact/common/loading.dart';
import 'package:arya_contact/contact/contact_bloc_provider.dart';
import 'package:arya_contact/contact/contact_data.dart';
import 'package:arya_contact/map/map_bloc.dart';
import 'package:arya_contact/map/map_provider.dart';
import 'package:arya_contact/search/address_search_bloc.dart';
import 'package:arya_contact/search/address_search_bloc_provider.dart';
import 'package:arya_contact/search/address_search_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:rxdart/rxdart.dart';


class MapView extends StatelessWidget {
  MapView({Key key}) : super(key: key);
  bool showHelp = true;
  LatLng currentViewPoint;
  MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    currentViewPoint = UnassignedLocation();
    MapBloc mapBloc = MapBlocProvider.of(context);
    AddressSearchBloc searchBloc = AddressSearchBlocProvider.of(context);

    mapBloc.viewPoint.listen((loc) {
      if (!(loc is UnassignedLocation)) {
        mapController.move(loc, 14);
      }
    });
    searchBloc.latestSelected
        .map((loc) => loc.location)
        .listen(mapBloc.setViewPoint.add);

    Timer(Duration(seconds: 6), () {
      showHelp = false;
    });

    return StreamBuilder<MergedMapData>(
      stream: mergeMapData(mapBloc),
      builder: (context, mapSnapshot) {
        if (mapSnapshot.hasData) {

          AddressSearchBlocProvider.of(context).latestSelected.listen((sr) {
            print(sr.name);
          });

          return Stack(children: <Widget>[
            StreamBuilder<LatLng>(
              stream: mapBloc.viewPoint,
              builder: (context, viewpointSnapshot) {
                return new FlutterMap(
                  mapController: mapController,
                  options: new MapOptions(
                    center: LatLng(36.683, 48.50),
                    onTap: (latLng) {},
                    onPositionChanged: (mapPosition) {
                      mapBloc.mapCenter = mapPosition.center;
                      print("map position: ${mapPosition.center.toString()}");
                      print("new location: ${mapBloc.mapCenter.toString()}");
                    },
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
                  ],
                );
              },
            ),
            /* !mapSnapshot.data.clickable
                ? new Container(color: Color.fromARGB(0, 255, 240, 240))
                : Container(),*/
            mapSnapshot.data.clickable
                ? StreamBuilder<bool>(
                    stream: mapBloc.showCenterPointer,
                    builder: (context, showCenterPointerSnapshot) {
                      if (showCenterPointerSnapshot.hasData) {
                        return showCenterPointerSnapshot.data
                            ? GestureDetector(
                                onTap: () {
                                  mapBloc.setLocation.add(mapBloc.mapCenter);
                                  print("locc" + mapBloc.mapCenter.toString());
                                },
                                child: new Align(
                                  alignment: FractionalOffset.center,
                                  child: new Container(
                                    width: 100,
                                    height: 100,
                                    child: Stack(
                                      children: <Widget>[
                                        new Container(
                                            height: 100,
                                            alignment: Alignment.center,
                                            child: new Image.asset(
                                                "assets/location_icon.png")),
                                        Container(
                                          width: 100,
                                          height: 73,
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "اینجا",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Container();
                      } else {
                        return LoadingSpinner();
                      }
                    },
                  )
                : StreamBuilder<bool>(
                    stream: mapBloc.clickable,
                    builder: (context, clickable) {
                      print("CLICKCCCC ${clickable.data}");
                      return !clickable.data ? Container() : LoadingSpinner();
                    },
                  )
          ]);
        } else {
          return Container(
            child: LoadingSpinner(),
          );
        }
      },
    );
  }

  static Stream<MergedMapData> mergeMapData(MapBloc bloc) {
    return Observable.combineLatest3(
        bloc.clickable,
        bloc.viewPoint,
        bloc.zoom,
        (clickable, viewPoint, zoom) =>
            new MergedMapData(clickable, viewPoint, zoom));
  }

/* Stream<bool> getLoadingVisibility(BuildContext context) {
    .
    listen
    (
    (
    c
    )
    {

    }
    )
  }*/
}

class MergedMapData {
  final bool clickable;
  final LatLng viewPoint;
  final double zoom;

  MergedMapData(this.clickable, this.viewPoint, this.zoom);
}
