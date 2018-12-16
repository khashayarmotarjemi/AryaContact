import 'package:flutter/material.dart';
import 'package:arya_contact/common/loading.dart';
import 'package:arya_contact/contact/contact_bloc_provider.dart';
import 'package:arya_contact/contact/contact_data.dart';
import 'package:arya_contact/contact/widgets/contact_item.dart';

class ContactList extends StatelessWidget {
  ContactList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ContactData>(
      stream: ContactsBlocProvider.of(context).contactData,
      builder: (context, snapshot) => snapshot.hasData
          ? _buildList(snapshot.data.contacts)
          : LoadingSpinner(),
    );
  }

  ListView _buildList(List<Contact> contacts) {
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (BuildContext context, int index) {
        final contact = contacts[index];

        return ContactItem(
          contact: contact,
          onTap: () {
            /*Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) {
                  return DetailScreen(
                    todoId: contact.id,
                    initBloc: () =>
                        TodoBloc(Injector.of(context).todosInteractor),
                  );
                },
              ),
            ).then((todo) {
              if (todo is Todo) {
                _showUndoSnackbar(context, todo);
              }
            });*/
          },
        );
      },
    );
  }

}
