import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:maps_test/contact/contact_data.dart';

class ContactItem extends StatelessWidget {
  final GestureTapCallback onTap;
  final Contact contact;

  ContactItem({
    @required this.onTap,
    @required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Text(contact.name),
      title: Text(
        contact.phoneNumber,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }
}
