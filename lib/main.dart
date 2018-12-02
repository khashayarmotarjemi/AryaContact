import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new FlutterMap(
      options: new MapOptions(
        onTap: (latlng) {
          print(latlng.latitude);
        },
        center: new LatLng(36.6830, 48.5087),
        zoom: 12.0,
      ),
      layers: [
        new TileLayerOptions(
          urlTemplate: "https://map.ir/shiveh/shiveh?service=WMS&version=1.1.1&request=GetMap&layers=Shiveh%3AShiveh&srs=EPSG%3A3857&bbox={x}%{y}%{z}%2C4265797.674539116&width=256&height=256&format=image%2Fpng",

/*          urlTemplate: "https://api.tiles.mapbox.com/v4/"
              "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",*/

          additionalOptions: {
            'accessToken':
                'pk.eyJ1Ijoia2hhc2hheWFybW90YXJqZW1pIiwiYSI6ImNqb3d1NWRxeTFscDMzcG85aGxpcTM3YmMifQ.LUFyMRYSzoYWbrNlyHb_yQ',
            'id': 'mapbox.streets',
          },
        ),
        new MarkerLayerOptions(
            /*markers: [
            new Marker(
              width: 80.0,
              height: 80.0,
              point: new LatLng(51.5, -0.09),
              builder: (ctx) => new Container(
                    child: new FlutterLogo(),
                  ),
            ),
          ],*/
            ),
      ],
    );
  }
}
