import 'dart:async';

import 'package:arya_contact/contact/contact_bloc.dart';
import 'package:arya_contact/contact/contact_bloc_provider.dart';
import 'package:arya_contact/contact/contact_data.dart';
import 'package:arya_contact/contact/contact_repository.dart';
import 'package:arya_contact/screens/contacts_screen.dart';
import 'package:arya_contact/map/map_bloc.dart';
import 'package:arya_contact/map/map_provider.dart';
import 'package:arya_contact/postal/postal_bloc.dart';
import 'package:arya_contact/postal/postal_data.dart';
import 'package:arya_contact/postal/postal_repository.dart';
import 'package:arya_contact/screens/home_screen.dart';
import 'package:arya_contact/search/address_search_bloc.dart';
import 'package:arya_contact/search/address_search_bloc_provider.dart';
import 'package:arya_contact/search/address_search_repository.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:mockito/mockito.dart';

class MockContactRepo extends Mock implements ContactRepository {}

class MockPostalRepo extends Mock implements PostalRepository {}

void main() {
  /* AddressSearchRepository()
      .getSearchLocations("سبزه میدان")
      .then((l) => print(l[3].name));
*/
  // mocks
  MockContactRepo mockContactRepo = new MockContactRepo();
  PostalRepository mockPostalRepo = new WebPostalRepository();
  when(mockContactRepo.getContactData(new PostalData("12"))).thenAnswer((_) {
    return Future.delayed(
        Duration(seconds: 0),
        () => Future.value(ContactData([
              new Contact("+24 3345 8561", "فروشگاه اول", 1),
              new Contact("+24 3345 8561", "فروشگاه دوم", 7),
              new Contact("+24 3345 8561", "فروشگاه سوم", 2),
              new Contact("+24 3345 8561", "فروشگاه چهارم", 3),
              new Contact("+24 3345 8561", "فروشگاه اول", 6),
              new Contact("+24 3345 8561", "فروشگاه اول", 3),
              new Contact("+24 3345 8561", "فروشگاه اول", 2),
              new Contact("+24 3345 8561", "فروشگاه اول", 7)
            ])));
  });

  when(mockContactRepo.getContactData(new EmptyPostalData())).thenAnswer((_) {
    return Future.value(new EmptyContactData());
  });

  /* when(mockPostalRepo.getPostalData(UnassignedLocation())).thenAnswer((_) {
    return Future.value(new EmptyPostalData());
  });*/

  /*when(mockPostalRepo.getPostalData(LatLng(32, 32))).thenAnswer((_) {
    return Future.value(new PostalData("12"));
  });*/

////////////////////////////////////////////////////////////////////////////////

  // main
  WebPostalRepository postalRepo = WebPostalRepository();
  AddressSearchRepository searchRepo = AddressSearchRepository();


  var mapBloc = new MapBloc(new LatLng(36.683, 48.50));
  var contactsBloc = new ContactBloc(mockContactRepo);
  var postalBloc = new PostalBloc(mockPostalRepo);
  var searchBloc = new AddressSearchBloc(searchRepo);

  mapBloc.viewPoint.listen((vp) => print("VP:  " + vp.toString()));
  mapBloc.location.listen((v) => print("LOCATION:  " + v.toString()));
  mapBloc.clickable.listen((v) => print("CLICKABLE:  " + v.toString()));
  mapBloc.zoom.listen((v) => print("ZOOM:  " + v.toString()));

  // bloc wiring
  mapBloc.location.listen(postalBloc.setLocation.add);
  postalBloc.postalData.listen(contactsBloc.setPostal.add);
  mapBloc.setViewPoint.add(LatLng(36.683, 48.50));

  // app
  runApp(AddressSearchBlocProvider(
      bloc: searchBloc,
      child: MapBlocProvider(
        bloc: mapBloc,
        child: ContactsBlocProvider(
          bloc: contactsBloc,
          child: MaterialApp(
              title: "arya-contact",
              theme: ThemeData(
                brightness: Brightness.light,
                primaryColor: Colors.red[400],
                accentColor: Colors.redAccent,

            fontFamily: 'IranSans',

                textTheme: TextTheme(
                  headline:
                      TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
                  title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
                  body1: TextStyle(fontSize: 14.0, fontFamily: 'Shabnam'),
                ),
              ),
              routes: {
/*
                '/map': (context) => HomeScreen(),
*/
//                '/': (context) => LoginScreen(),
              }),
        ),
      )));
}
