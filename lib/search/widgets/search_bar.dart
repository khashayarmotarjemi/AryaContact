import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final ValueChanged<String> onChanged;

  @override
  _SearchBarState createState() => _SearchBarState();

  SearchBar({@required this.onChanged});
}

class _SearchBarState extends State<SearchBar> {
  bool typingMode = false;
  final textController = TextEditingController();

  FocusNode textFocusNode;

  @override
  void initState() {
    super.initState();
    textFocusNode = FocusNode();
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
    // search
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
                      FocusScope.of(context).requestFocus(FocusNode());
                      typingMode = false;
                    } else {
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
                  width: 100,
                  height: 52,
                  child: TextField(
                      focusNode: textFocusNode,
                      controller: textController,
                      onChanged: widget.onChanged,
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                          hintText: "جستجوی آدرس", border: InputBorder.none),
                      onTap: () {
                        setState(() {
                          typingMode = true;
                        });
                      }))
            ],
          ),
        ));
  }
}
