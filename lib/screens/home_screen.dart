
import 'package:arya_contact/contact/contact_bloc_provider.dart';
import 'package:arya_contact/contact/contact_data.dart';
import 'package:arya_contact/map/map_provider.dart';
import 'package:arya_contact/map/map_view.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

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

    return StreamBuilder<ContactData>(
      stream: contactsBloc.contactData,
      builder: (context, userSnapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Contact"),
          ),
          body: Stack(children: <Widget>[
            MapView(),
          ],),
          floatingActionButton:
              FloatingActionButton(onPressed: () {}, child: Icon(Icons.my_location)),
        );
      },
    );
  }
}
