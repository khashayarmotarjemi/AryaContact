import 'package:arya_contact/categories/category_entity.dart';
import 'package:arya_contact/screens/contacts_screen.dart';
import 'package:arya_contact/contact/widgets/contact_list.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final CategoryEntity category;
  final int itemCount;

  CategoryItem(this.category, this.itemCount);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ContactsScreen(
                    category,
                  )));
        },
        child: Card(
          elevation: 7,
          margin: EdgeInsets.all(5),
          child: new Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Container(
                    child: Center(
                      child: Text(
                        category.name,
                        style: TextStyle(fontSize: 18, color: category.color),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: category.color,
                  width: 0,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Icon(
                            category.icon,
                            color: category.color,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Text(itemCount.toString()),
                          ),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(5))),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
