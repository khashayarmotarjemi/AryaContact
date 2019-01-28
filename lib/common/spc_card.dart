import 'package:flutter/material.dart';

class SpcCard extends StatelessWidget {
  final Widget _child;

  SpcCard( this._child);

  @override
  Widget build(BuildContext context) {
    return new Card(color: Colors.red,
        elevation: 4,

        child: Card(
          margin: EdgeInsets.only(left: 5,right: 5,top: 3,bottom: 3),
          elevation: 0,
          child: (_child),
        ),
    );
  }
}
