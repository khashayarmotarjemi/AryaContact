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
    return FlatButton(
        onPressed: onTap,
        child: new Container(
          height: 150,
          child: new Card(
              elevation: 4,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 100,
                      child: Image.network(contact.imgUrl),
                    ),
                    Container(
                      width: 230,
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              contact.name,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(top: 10),
                            child: Text("توضیحات"),
                          ),
                          Container(
                              padding: EdgeInsets.only(top: 13, left: 30),
                              child: Container(
                                height: 56,
                                width: 200,
                                child: Card(
                                  elevation: 6,
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(
                                            right: 10, left: 10),
                                        child: Icon(
                                          Icons.phone,
                                          color: Colors.green,
                                        ),
                                      ),
                                      Container(
                                        width: 1,
                                        height: 27,
                                        color: Colors.grey,
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.only(left: 10, right: 4),
                                        child: Text(
                                          contact.phoneNumber,
                                          style: TextStyle(
                                              locale: Locale('ar'),
                                              fontSize: 16),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ));
  }
}
