import 'package:arya_contact/common/loading.dart';
import 'package:arya_contact/contact/contact_bloc.dart';
import 'package:arya_contact/contact/contact_bloc_provider.dart';
import 'package:arya_contact/contact/contact_data.dart';
import 'package:arya_contact/contact/widgets/contact_list.dart';
import 'package:arya_contact/map/map_bloc.dart';
import 'package:arya_contact/map/map_provider.dart';
import 'package:arya_contact/map/map_view.dart';
import 'package:arya_contact/postal/postal_data.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen() : super();

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /*void setUp(
      AsyncSnapshot<MergedMapData> mapSnapshot,
      AsyncSnapshot<ContactData> contactSnapshot,
      MapBloc mapBloc,
      ContactBloc contactBloc) {
    if (mapSnapshot.data != null &&
        mapSnapshot.data.marker != UnassignedLocation()) {

    }
  }*/

  @override
  Widget build(BuildContext context) {
    final contactsBloc = ContactsBlocProvider.of(context);
    final mapBloc = MapBlocProvider.of(context);

    return StreamBuilder<ContactData>(
        stream: contactsBloc.contactData,
        builder: (context, contactSnapshot) {
          return StreamBuilder<MergedMapData>(
              stream: MapView.mergeMapData(mapBloc),
              builder: (context, mapSnapshot) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text("نقشه"),
                  ),
                  body: Stack(
                    children: <Widget>[
                      MapView(),
                      mapSnapshot.hasData &&
                              mapSnapshot.data.marker != UnassignedLocation() &&
                              contactSnapshot.data.contacts.isEmpty
                          ? LoadingSpinner()
                          : Container(),
                      contactSnapshot.hasData &&
                              contactSnapshot.data.contacts.isNotEmpty
                          ? Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(bottom: 0),
                              child: Container(
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  color: Color.fromARGB(120, 240, 240, 240),
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: 56),
                                    child: new ContactList(),
                                  )))
                          : Container(),
                      mapSnapshot.hasData &&
                              contactSnapshot.data.contacts.isNotEmpty
                          ? Stack(
                              children: <Widget>[
                                new Container(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 56,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                new Container(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    padding:
                                        EdgeInsets.only(left: 50, right: 50),
                                    height: 59,
                                    child: FlatButton(
                                        onPressed: () {
                                          mapBloc.reset.add(null);
                                          contactsBloc.reset.add(null);
                                        },
                                        child: Card(
                                          elevation: 6,
                                          color: Colors.red[400],
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(0)),
                                          child: new Container(
                                            height: 59,
                                            width: 200,
                                            alignment: Alignment.center,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  "تغییر محل",
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.white),
                                                ),
                                                Container(
                                                  padding:
                                                      EdgeInsets.only(left: 8),
                                                  child: Icon(
                                                    Icons.clear,
                                                    size: 24,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )),
                                  ),
                                ),
                              ],
                            )
                          : new Container(),
                    ],
                  ),
                  floatingActionButton: mapSnapshot.hasData &&
                          contactSnapshot.data.contacts == EmptyContactData()
                      ? FloatingActionButton(
                          onPressed: () async {
                            var currentLocation = <String, double>{};
                            var location = Location();
                            /*try {
                              currentLocation = await location.getLocation();
                              mapBloc.setViewPoint.add(new LatLng(
                                  currentLocation['latitude'],
                                  currentLocation['longitude']));
                            } on Exception {
                              currentLocation = null;
                            }*/
                          },
                          child: Icon(Icons.my_location))
                      : Container(),
                );
              });
        });
  }
}
