import 'package:arya_contact/search/address_search_bloc_provider.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();

  SearchBar();
}

class _SearchBarState extends State<SearchBar> {
  bool typingMode = false;
  final textController = TextEditingController();

  FocusNode textFocusNode;

  @override
  void initState() {
    super.initState();
    textFocusNode = FocusNode();

    // for initialising after changing focus
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed
    textFocusNode.dispose();
    textController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var addressSearchBloc = AddressSearchBlocProvider.of(context);
    // search

    textFocusNode.addListener(() {
      addressSearchBloc.search.add(textController.text);
      print("focused  ${textController.text.toString()} ");
    });

    return SizedBox(
        width: double.infinity,
        height: 78,
        child: Card(
          elevation: 7,
          margin: EdgeInsets.only(top: 30, left: 8, right: 8),
          child: Row(
            textDirection: TextDirection.rtl,
            children: <Widget>[
              FlatButton.icon(
                onPressed: () {
                  setState(() {
                    if (typingMode) {
                      textController.text = "";
                      addressSearchBloc.setResultVisibility.add(false);
                      FocusScope.of(context).requestFocus(FocusNode());
                      typingMode = false;
                    } else {
                      addressSearchBloc.setResultVisibility.add(true);
                      FocusScope.of(context).requestFocus(textFocusNode);
                      typingMode = true;
                    }
                  });
                },
                icon: Icon(
                  typingMode ? Icons.clear : Icons.search,
                  color: Colors.redAccent,
                ),
                label: Container(),
              ),
              Container(
                  width: 200,
                  height: 52,
                  child: TextField(
                      focusNode: textFocusNode,
                      controller: textController,
                      onChanged: addressSearchBloc.search.add,
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                        hintText: "جستجوی آدرس",
                        border: InputBorder.none,
                      ),
                      onTap: () {
                        setState(() {
                          typingMode = true;
                          addressSearchBloc.setResultVisibility.add(true);
                        });
                      }))
            ],
          ),
        ));
  }
}
