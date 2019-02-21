import 'dart:async';

import 'package:arya_contact/categories/category_entity.dart';
import 'package:arya_contact/categories/category_list.dart';
import 'package:arya_contact/common/loading.dart';
import 'package:arya_contact/contact/contact_bloc_provider.dart';
import 'package:arya_contact/contact/contact_data.dart';
import 'package:arya_contact/contact/widgets/contact_list.dart';
import 'package:arya_contact/map/map_bloc.dart';
import 'package:arya_contact/map/map_provider.dart';
import 'package:arya_contact/map/map_view.dart';
import 'package:arya_contact/search/widgets/search_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:latlong/latlong.dart';

var categories = [
  CategoryEntity(
      "سوپرمارکت", "", Colors.green[700], Icons.local_grocery_store, 1),
  CategoryEntity("رستوران", "", Colors.red[700], Icons.restaurant, 2),
  CategoryEntity("داروخانه", "", Colors.blue[700], Icons.local_pharmacy, 3),
  CategoryEntity("دسته بندی", "", Colors.blueGrey[700], Icons.category, 4),
  CategoryEntity("دسته بندی", "", Colors.blueGrey[700], Icons.category, 5),
  CategoryEntity("پزشک", "", Colors.cyan[700], Icons.healing, 6),
  CategoryEntity("مرکز آموزشی", "", Colors.brown, Icons.school, 7),
  CategoryEntity("دسته بندی", "", Colors.blueGrey[700], Icons.category, 8),
  CategoryEntity("دسته بندی", "", Colors.blueGrey[700], Icons.category, 9),
  CategoryEntity("دسته بندی", "", Colors.blueGrey[700], Icons.category, 10),
];

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

  @override
  Widget build(BuildContext context) {
    final contactsBloc = ContactsBlocProvider.of(context);
    final mapBloc = MapBlocProvider.of(context);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return StreamBuilder<ContactData>(
        stream: contactsBloc.contactData,
        builder: (context, contactSnapshot) {
          /*return StreamBuilder<MergedMapData>(
              stream: MapView.mergeMapData(mapBloc),
              builder: (context, mapSnapshot) {
              });*/

          if (contactSnapshot.hasData &&
              contactSnapshot.data.contacts.isNotEmpty) {
            mapBloc.setClickable.add(false);
          } else {
            mapBloc.setClickable.add(true);
          }

          return new StreamBuilder<LatLng>(
            stream: mapBloc.location,
            builder: (context, selectedLocationSnapshot) {
              if (true) {
                return Scaffold(
                  body: Stack(
                    children: <Widget>[
                      MapView(),
                      SearchArea(),
/*
                      mapSnapshot.hasData &&
*/
                      selectedLocationSnapshot.data != UnassignedLocation() &&
                              contactSnapshot.hasData &&
                              contactSnapshot.data.contacts.isEmpty
                          ? Container()
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
                                    // the list
                                    child: Container(
                                      child: CategoryList(
                                          categories,
                                          getCategoryCountMap(
                                              contactSnapshot.data.contacts)),
                                      margin: EdgeInsets.only(top: 26),
                                    ),
                                  )))
                          : Container(),
/*
                      mapSnapshot.hasData &&
*/
                      contactSnapshot.data.contacts.isNotEmpty
                          ? new Stack(
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
                  floatingActionButton: /*mapSnapshot.hasData &&*/
                      selectedLocationSnapshot.data == UnassignedLocation()
                          ? FloatingActionButton(
                              onPressed: () async {
                               /* LocationData currentLocation;

                                var location = new Location();

                                try {
                                  location.getLocation().then((loc) {
                                    print(loc.toString());
                                  });
                                } on PlatformException {
                                  currentLocation = null;
                                }*/
                              },
                              child: Icon(Icons.my_location))
                          : Container(),
                );
              } else {
                return Container(
                  color: Colors.blue,
                  child: LoadingSpinner(),
                );
              }
            },
          );
        });
  }

  Map<int, int> getCategoryCountMap(List<Contact> contacts) {
    var map = new Map<int, int>();
    int currentCount;
    contacts.forEach((contact) {
      currentCount =
          map.containsKey(contact.categoryId) ? map[contact.categoryId] : 0;
      print("current count: $currentCount");
      currentCount == 0
          ? map.putIfAbsent(contact.categoryId, () => 1)
          : map.update(contact.categoryId, (prv) => prv + 1);
    });

    print(map.toString());

    return map;
  }
}
