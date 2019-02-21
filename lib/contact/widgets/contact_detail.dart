import 'package:arya_contact/contact/contact_data.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDetail extends StatelessWidget {
  final Contact contact;

  ContactDetail(this.contact);

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 600,
      alignment: Alignment.center,
      color: Colors.red,
      child: Scaffold(
        appBar: AppBar(
            title: Container(
                padding: EdgeInsets.only(right: 44),
                alignment: Alignment.center,
                child: Text("جزییات"))),
        body: new Card(
            elevation: 4,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 60),
                    height: 270,
                    child: Image.network(contact.imgUrl),
                  ),
                  new Row(
                    children: <Widget>[
                      Container(
                        width: 330,
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
                                    child: new Row(
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
                                          onTap: () => launch(
                                              "tel://${contact.phoneNumber}"),
                                        ),
                                        Container(
                                          width: 1,
                                          height: 27,
                                          color: Colors.grey,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 4),
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
                  )
                ],
              ),
            )),
      ),
    );
  }
}