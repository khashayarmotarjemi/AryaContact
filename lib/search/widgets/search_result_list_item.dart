import 'package:arya_contact/search/address_search_repository.dart';
import 'package:flutter/material.dart';

class SearchResultItem extends StatelessWidget {
  final GestureTapCallback onTap;
  final SearchResult result;

  SearchResultItem({
    @required this.onTap,
    @required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FlatButton(
            onPressed: onTap,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 20,top: 20),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.place,color: Color.fromARGB(90, 255, 10, 10),),
                      Expanded(
                        child:
                            Text(result.name, textDirection: TextDirection.rtl),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 1,
                  width: double.infinity,
                  child: Container(color: Color.fromARGB(80, 80, 80, 80)),
                )
              ],
            )));
  }
}
