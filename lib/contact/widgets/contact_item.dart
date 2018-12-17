import 'package:arya_contact/contact/contact_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ContactItem extends StatelessWidget {
  final GestureTapCallback onTap;
  final Contact contact;

  ContactItem({
    @required this.onTap,
    @required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 100,
      child: new Card(
        elevation: 4,
        child: ListTile(
          onTap: onTap,
          /* leading: Text(contact.name),
        title: Text(
          contact.phoneNumber,
          style: Theme.of(context).textTheme.title,
        ),*/
        ),
      ),
    );
  }
}
