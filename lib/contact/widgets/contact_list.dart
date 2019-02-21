import 'package:arya_contact/common/loading.dart';
import 'package:arya_contact/contact/contact_bloc_provider.dart';
import 'package:arya_contact/contact/contact_data.dart';
import 'package:arya_contact/contact/widgets/contact_detail.dart';
import 'package:arya_contact/contact/widgets/contact_item.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class ContactList extends StatelessWidget {
  final int categoryId;

  ContactList({Key key, this.categoryId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ContactData>(
      stream: ContactsBlocProvider.of(context).contactData,
      builder: (context, snapshot) => snapshot.hasData
          ? _buildList(context,
              snapshot.data.contacts.where((c) => c.categoryId == categoryId).toList())
          : LoadingSpinner(),
    );
  }

  ListView _buildList(BuildContext context, List<Contact> contacts) {
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (BuildContext context, int index) {
        final contact = contacts[index];

        return ContactItem(
          contact: contact,
          onTap: () {
            print("clicked");
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => ContactDetail(contact)));
          },
        );
      },
    );
  }
}
