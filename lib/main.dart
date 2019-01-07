import 'dart:async';

import 'package:arya_contact/contact/contact_bloc.dart';
import 'package:arya_contact/contact/contact_bloc_provider.dart';
import 'package:arya_contact/contact/contact_data.dart';
import 'package:arya_contact/contact/contact_repository.dart';
import 'package:arya_contact/map/map_bloc.dart';
import 'package:arya_contact/map/map_provider.dart';
import 'package:arya_contact/postal/postal_bloc.dart';
import 'package:arya_contact/postal/postal_data.dart';
import 'package:arya_contact/postal/postal_repository.dart';
import 'package:arya_contact/screens/home_screen.dart';
import 'package:arya_contact/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:mockito/mockito.dart';

class MockContactRepo extends Mock implements ContactRepository {}

class MockPostalRepo extends Mock implements PostalRepository {}

void main() {

  AddressSearchRepository().getSearchLocations("سبزه میدان").then((l) => print(l[3].name));


  // mocks
  MockContactRepo mockContactRepo = new MockContactRepo();
  MockPostalRepo mockPostalRepo = new MockPostalRepo();
  when(mockContactRepo.getContactData(new PostalData("12"))).thenAnswer((_) {
    return Future.delayed(
        Duration(seconds: 3),
        () => Future.value(ContactData([
              new Contact("+24 3345 8561", "فروشگاه اول"),
              new Contact("+24 3345 8561", "فروشگاه دوم"),
              new Contact("+24 3345 8561", "فروشگاه سوم"),
              new Contact("+24 3345 8561", "فروشگاه چهارم"),
              new Contact("+24 3345 8561", "فروشگاه اول"),
              new Contact("+24 3345 8561", "فروشگاه اول"),
              new Contact("+24 3345 8561", "فروشگاه اول"),
              new Contact("+24 3345 8561", "فروشگاه اول")
            ])));
  });

  when(mockContactRepo.getContactData(new EmptyPostalData())).thenAnswer((_) {
    return Future.value(new EmptyContactData());
  });

  when(mockPostalRepo.getPostalData(UnassignedLocation())).thenAnswer((_) {
    return Future.value(new EmptyPostalData());
  });

  when(mockPostalRepo.getPostalData(LatLng(32, 32))).thenAnswer((_) {
    return Future.value(new PostalData("12"));
  });

////////////////////////////////////////////////////////////////////////////////


  // main
  WebPostalRepository postalRepo = WebPostalRepository();


  // bloc wiring
  var mapBloc = new MapBloc(new LatLng(36.683, 48.50));
  var contactsBloc = new ContactBloc(mockContactRepo);
  var postalBloc = new PostalBloc(mockPostalRepo);

  mapBloc.location.listen(postalBloc.setLocation.add);
  postalBloc.postalData.listen(contactsBloc.setPostal.add);


  // app
  runApp(MapBlocProvider(
    bloc: mapBloc,
    child: ContactsBlocProvider(
      bloc: contactsBloc,
      child: MaterialApp(
          title: "arya-contact",
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.red[400],
            accentColor: Colors.redAccent,

            fontFamily: 'Shabnam',

            textTheme: TextTheme(
              headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
              title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
              body1: TextStyle(fontSize: 14.0, fontFamily: 'Shabnam'),
            ),
          ),
          routes: {
           '/': (context) => LoginScreen(),
            '/map': (context) => HomeScreen()
/*
            '/': (context) => HomeScreen()
*/
          }),
    ),
  ));
}
