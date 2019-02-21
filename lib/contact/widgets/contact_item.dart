import 'package:arya_contact/contact/contact_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactItem extends StatelessWidget {
  final GestureTapCallback onTap;
  final Contact contact;

  ContactItem({
    @required this.onTap,
    @required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: new SizedBox(
          height: 150,
          width: double.infinity,
          child: new Card(
              elevation: 4,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 100,
                      child: Image.network(
                        contact.imgUrl,
                        width: 100,
                        height: 100,
                      ),
                    ),
                    Container(
                      width: 230,
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(right: 25),
                            alignment: Alignment.centerRight,
                            child: Text(
                              contact.name,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(top: 10, right: 25),
                            child: Text("متن توضیحات ..."),
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
                                      GestureDetector(
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              right: 10, left: 10),
                                          child: Icon(
                                            Icons.phone,
                                            color: Colors.green,
                                          ),
                                        ),
                                        onTap: () {
                                          launch("tel://${contact.phoneNumber}");
                                          print("phone clicked");
                                        },
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
