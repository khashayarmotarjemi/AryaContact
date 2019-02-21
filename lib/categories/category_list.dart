import 'package:arya_contact/categories/category_entity.dart';
import 'package:arya_contact/categories/category_item.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  final List<CategoryEntity> categories;
  final Map<int, int> categoryCount;

  CategoryList(this.categories, this.categoryCount);

  @override
  Widget build(BuildContext context) {
    print("ASDFASDF" + categoryCount.toString());

    int firstColumnCount = categories.length ~/ 2;
    int secondColumnCount = categories.length - firstColumnCount;

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: List.generate(firstColumnCount, (index) {
                var category = categories[index];

                return Expanded(
                  child: CategoryItem(category, categoryCount[category.id]),
                );
              }),
            ),
          ),
          Expanded(
            child: Column(
              children: List.generate(secondColumnCount, (index) {
                var category = categories[index + firstColumnCount];

                return Expanded(
                  child: CategoryItem(category, categoryCount[category.id]),
                );
              }),
            ),
          )
        ],
      ),
    );

    /* return GridView.count(
        crossAxisCount: 2,
        // Generate 100 Widgets that display their index in the List
        children: List.generate(10, (index) {
         */ /* return Container(
            margin: EdgeInsets.all(8),
            color: Colors.red,
          );*/ /*
          return Expanded(flex: 10, child: Container(width: 30,height: 30,color: Colors.red,),);
        }));*/
  }
}
