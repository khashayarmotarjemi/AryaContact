import 'dart:async';

import 'package:arya_contact/contact/contact_bloc.dart';
import 'package:arya_contact/contact/contact_bloc_provider.dart';
import 'package:arya_contact/contact/contact_data.dart';
import 'package:arya_contact/contact/contact_repository.dart';
import 'package:arya_contact/map/map_bloc.dart';
import 'package:arya_contact/map/map_provider.dart';
import 'package:arya_contact/postal/postal_data.dart';
import 'package:arya_contact/screens/home_screen.dart';
import 'package:arya_contact/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:mockito/mockito.dart';

class MockContactRepo extends Mock implements ContactRepository {}

void main() {
  MockContactRepo mockRepo = new MockContactRepo();
  when(mockRepo.getContactData(new PostalData("12"))).thenAnswer((_) {
    return Future.delayed(
        Duration(seconds: 3),
        () => Future.value(ContactData([
              new Contact("+24 3345 8561", "فروشگاه اول"),
              new Contact("+24 3345 8561", "فروشگاه اول"),
              new Contact("+24 3345 8561", "فروشگاه اول"),
              new Contact("+24 3345 8561", "فروشگاه اول"),
              new Contact("+24 3345 8561", "فروشگاه اول"),
              new Contact("+24 3345 8561", "فروشگاه اول"),
              new Contact("+24 3345 8561", "فروشگاه اول"),
              new Contact("+24 3345 8561", "فروشگاه اول")
            ])));
  });

  when(mockRepo.getContactData(new EmptyPostalData())).thenAnswer((_) {
    return Future.value(new EmptyContactData());
  });

  var bloc = new ContactBloc(mockRepo);

  bloc.contactData.listen((contactdata) {
    print(contactdata.contacts);
  });

  var mapBloc = new MapBloc(new LatLng(36.683, 48.50));
  var contactsBloc = new ContactBloc(mockRepo);

  runApp(MapBlocProvider(
    bloc: mapBloc,
    child: ContactsBlocProvider(
      bloc: contactsBloc,
      child: MaterialApp(
          title: "arya-contact",
          theme: ThemeData(
            // Define the default Brightness and Colors
            brightness: Brightness.light,
            primaryColor: Colors.red[400],
            accentColor: Colors.redAccent,

            // Define the default Font Family
            fontFamily: 'Shabnam',

            // Define the default TextTheme. Use this to specify the default
            // text styling for headlines, titles, bodies of text, and more.
            textTheme: TextTheme(
              headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
              title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
              body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
            ),
          ),
          routes: {
            '/': (context) => LoginScreen(),
            '/map': (context) => HomeScreen()
          }),
    ),
  ));
}

/*
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new HomeScreen());
  }
}*/

/*
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  LatLng centerPosition;
  MapInteractor interactor;

  bool isLoading = false;
  bool loaded = false;

  void locationSelected() async {
    setState(() {
      loaded = false;
      isLoading = true;
    });
  }

  void loadAndShowPhoneNumbers() async {
    new Timer(Duration(milliseconds: 2500), () {
      setState(() {
        isLoading = false;
        loaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print("loaded: " + loaded.toString());
    print("isLoading: " + isLoading.toString());
    interactor = AppProvider.of(context);
    return new WillPopScope(
        child: new Scaffold(
            body: new Stack(children: <Widget>[
          new FlutterMap(
            options: new MapOptions(
              onPositionChanged: (mapPosition) {
                interactor.viewPoint = mapPosition.center;
              },
              onTap: (latlng) {
                print(interactor.viewPoint);
              },
              center: new LatLng(36.6830, 48.5087),
              zoom: 12.0,
            ),
            layers: [
              new TileLayerOptions(
                */
/*urlTemplate:
                "https://map.ir/shiveh/shiveh?service=WMS&version=1.1.1&request=GetMap&layers=Shiveh%3AShiveh&srs=EPSG%3A3857&bbox={x}%{y}%{z}%2C4265797.674539116&width=256&height=256&format=image%2Fpng",
*/ /*

                urlTemplate: "https://api.tiles.mapbox.com/v4/"
                    "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
                additionalOptions: {
                  'accessToken':
                      'pk.eyJ1Ijoia2hhc2hheWFybW90YXJqZW1pIiwiYSI6ImNqb3d1NWRxeTFscDMzcG85aGxpcTM3YmMifQ.LUFyMRYSzoYWbrNlyHb_yQ',
                  'id': 'mapbox.streets',
                },
              ),
            ],
          ),
          (!isLoading && !loaded)
              ? new Container(
                  alignment: Alignment.center,
                  child: Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Card(
                        child: Container(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text("اینجا"),
                          ),
                          width: 80,
                          height: 35,
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          locationSelected();
                          loadAndShowPhoneNumbers();
                        },
                        child: new Icon(
                          Icons.place,
                          color: Colors.redAccent,
                          size: 70,
                        ),
                      )
                    ],
                  )))
              : Container(),
          (isLoading | loaded)
              ? new Opacity(
                  opacity: 0.7,
                  child: (isLoading && !loaded)
                      ? Container(
                          alignment: Alignment.center,
                          color: Colors.white,
                          child: Container(
                            child: CircularProgressIndicator(
                              valueColor:
                                  new AlwaysStoppedAnimation<Color>(Colors.red),
                            ),
                          ))
                      : Container(),
                )
              : Container(),
          (!isLoading && loaded)
              ? new Container(
                  color: Colors.yellow[50],
                  child: ListView(
                    children: <Widget>[
                      Card(
                        elevation: 4,
                        child: Column(
                          children: <Widget>[
                            ListTile(
                                leading: Text('company name'),
                                title: Icon(
                                  Icons.store,
                                  size: 50,
                                )),
                            ListTile(
                              leading: Icon(Icons.phone),
                              title: Text('+24 33445566'),
                            )
                          ],
                        ),
                      ),
                      Card(
                        elevation: 4,
                        child: Column(
                          children: <Widget>[
                            ListTile(
                                leading: Text('company name'),
                                title: Icon(
                                  Icons.store,
                                  size: 50,
                                )),
                            ListTile(
                              leading: Icon(Icons.phone),
                              title: Text('+24 33445566'),
                            )
                          ],
                        ),
                      ),
                      Card(
                        elevation: 4,
                        child: Column(
                          children: <Widget>[
                            ListTile(
                                leading: Text('company name'),
                                title: Icon(
                                  Icons.store,
                                  size: 50,
                                )),
                            ListTile(
                              leading: Icon(Icons.phone),
                              title: Text('+24 33445566'),
                            )
                          ],
                        ),
                      ),
                      Card(
                        elevation: 4,
                        child: Column(
                          children: <Widget>[
                            ListTile(
                                leading: Text('company name'),
                                title: Icon(
                                  Icons.store,
                                  size: 50,
                                )),
                            ListTile(
                              leading: Icon(Icons.phone),
                              title: Text('+24 33445566'),
                            )
                          ],
                        ),
                      ),
                      Card(
                        elevation: 4,
                        child: Column(
                          children: <Widget>[
                            ListTile(
                                leading: Text('company name'),
                                title: Icon(
                                  Icons.store,
                                  size: 50,
                                )),
                            ListTile(
                              leading: Icon(Icons.phone),
                              title: Text('+24 33445566'),
                            )
                          ],
                        ),
                      ),
                      Card(
                        elevation: 4,
                        child: Column(
                          children: <Widget>[
                            ListTile(
                                leading: Text('company name'),
                                title: Icon(
                                  Icons.store,
                                  size: 50,
                                )),
                            ListTile(
                              leading: Icon(Icons.phone),
                              title: Text('+24 33445566'),
                            )
                          ],
                        ),
                      ),
                      Card(
                        elevation: 4,
                        child: Column(
                          children: <Widget>[
                            ListTile(
                                leading: Text('company name'),
                                title: Icon(
                                  Icons.store,
                                  size: 50,
                                )),
                            ListTile(
                              leading: Icon(Icons.phone),
                              title: Text('+24 33445566'),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Container()
        ])),
        onWillPop: () {
          setState(() {
            isLoading = false;
            loaded = false;
          });
        });
  }
}

//-------------------------------------------------------//

class AppProvider extends StatefulWidget {
  final Widget child;
  final MapInteractor interactor;

  AppProvider({Key key, this.child, this.interactor}) : super(key: key);

  @override
  State createState() {
    return _AppProviderState();
  }

  static MapInteractor of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_AppProvider) as _AppProvider)
        .interactor;
  }
}

class _AppProviderState extends State<AppProvider> {
  @override
  Widget build(BuildContext context) {
    return _AppProvider(interactor: widget.interactor, child: widget.child);
  }
}

class _AppProvider extends InheritedWidget {
  final MapInteractor interactor;

  _AppProvider({Key key, this.interactor, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(_AppProvider oldWidget) {
    return interactor != oldWidget.interactor;
  }
}
*/
