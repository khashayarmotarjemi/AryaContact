import 'package:arya_contact/categories/category_entity.dart';
import 'package:arya_contact/contact/widgets/contact_list.dart';
import 'package:flutter/material.dart';

class ContactsScreen extends StatelessWidget {
  final CategoryEntity category;

  ContactsScreen(this.category);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            padding: EdgeInsets.only(right: 44),
            alignment: Alignment.center,
            child: Text(category.name)),
      ),
      body: ContactList(
        categoryId: category.id,
      ),
    );
  }
}
