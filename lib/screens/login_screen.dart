/*
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ride/common/bloc_provider.dart';
import 'package:ride/home/home_screen.dart';
import 'package:ride/home/passenger_home.dart';
import 'package:ride/rides/models/user_entity.dart';
import 'package:ride/user/user_bloc.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen() : super();

  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  String phone = "";
  String smsCode = "";
  String generatedCode = "";
  bool smsAvailable = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
          color: Colors.blueAccent,
          alignment: Alignment.center,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
              Widget>[
            new Container(
              width: 350,
              height: 120,
              padding: EdgeInsets.only(bottom: 30),
              child: Card(
                elevation: 13,
                child: Container(
                  alignment: Alignment.center,
                  child: new Text(
                    "ورود به سیستم",
                    style: TextStyle(color: Colors.blue, fontSize: 25),
                  ),
                ),
              ),
            ),
            new Container(
              width: 350,
              height: 180,
              child: Card(
                elevation: 10,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 48, top: 17),
                      child: TextField(
                        onChanged: (text) {
                          setState(() {
                            phone = text;
                            print(text);
                          });
                        },
                        keyboardType: TextInputType.number,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            icon: Icon(Icons.call),
                            border: UnderlineInputBorder(),
                            hintText: 'شماره تلفن'),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 48,
                        top: 26,
                      ),
                      child: TextField(
                        onChanged: (text) {
                          setState(() {
                            smsCode = text;
                          });
                        },
                        keyboardType: TextInputType.number,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        enabled: smsAvailable,
                        decoration: InputDecoration(
                            icon: Icon(Icons.sms),
                            border: new UnderlineInputBorder(),
                            hintText: 'کد دریافتی اس ام اس'),
                      ),
                    )
                  ],
                ),
              ),
            ),
            !smsAvailable
                ? new Container(
                    width: 145,
                    height: 70,
                    padding: EdgeInsets.only(top: 10),
                    child: Card(
                        elevation: 10,
                        child: Container(
                          child: FlatButton(
                              onPressed: () {
                                generatedCode = "1111";

                                setState(() {
                                  smsAvailable = true;
                                });
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      "دریافت کد",
                                      textScaleFactor: 1.4,
                                      style:
                                          TextStyle(color: Colors.green[700]),
                                    ),
                                    padding: EdgeInsets.only(right: 20),
                                  )
                                ],
                              )),
                        )),
                  )
                : new Container(
                    width: 145,
                    height: 70,
                    padding: EdgeInsets.only(top: 10),
                    child: Card(
                        elevation: 10,
                        child: Container(
                          child: FlatButton(
                              onPressed: () {
                                if (smsCode == generatedCode) {
                                  Timer(Duration(seconds: 1), () {
                                    BlocProvider.of<UserBloc>(context)
                                        .logUserIn
                                        .add(Passenger("khashayar motarjemi",
                                            phone, Sex.MALE, 20));
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomeScreen()));
                                  });
                                }
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      "ورود",
                                      textScaleFactor: 1.4,
                                      style:
                                          TextStyle(color: Colors.green[700]),
                                    ),
                                    padding: EdgeInsets.only(right: 20),
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    color: Colors.green[700],
                                  )
                                ],
                              )),
                        )),
                  ),
            new Container(
              padding: EdgeInsets.only(top: 60),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Icon(
                      Icons.pin_drop,
                      size: 80,
                      color: Colors.blue[900],
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(right: 30, left: 30),
                      child: Icon(Icons.arrow_forward,
                          size: 50, color: Colors.blue[900])),
                  Container(
                    child: Icon(Icons.directions_car, size: 80, color: Colors.blue[900]),
                  )
                ],
              ),
            )
          ])),
    );
  }
}
*/
