
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:maps_test/contact/contact_bloc.dart';

class ContactBlocProvider extends StatefulWidget {
  final Widget child;
  final ContactBloc bloc;

  ContactBlocProvider({Key key, @required this.child, @required this.bloc})
      : super(key: key);

  @override
  _ContactBlocProviderState createState() => _ContactBlocProviderState();

  static ContactBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_ContactBlocProvider)
    as _ContactBlocProvider)
        .bloc;
  }
}

class _ContactBlocProviderState extends State<ContactBlocProvider> {
  @override
  Widget build(BuildContext context) {
    return _ContactBlocProvider(bloc: widget.bloc, child: widget.child);
  }

  @override
  void dispose() {
    widget.bloc.close();
    super.dispose();
  }
}

class _ContactBlocProvider extends InheritedWidget {
  final ContactBloc bloc;

  _ContactBlocProvider({
    Key key,
    @required this.bloc,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_ContactBlocProvider old) => bloc != old.bloc;
}