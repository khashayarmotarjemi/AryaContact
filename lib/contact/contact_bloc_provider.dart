
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:arya_contact/contact/contact_bloc.dart';

class ContactsBlocProvider extends StatefulWidget {
  final Widget child;
  final ContactBloc bloc;

  ContactsBlocProvider({Key key, @required this.child, @required this.bloc})
      : super(key: key);

  @override
  _ContactsBlocProviderState createState() => _ContactsBlocProviderState();

  static ContactBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_ContactBlocProvider)
    as _ContactBlocProvider)
        .bloc;
  }
}

class _ContactsBlocProviderState extends State<ContactsBlocProvider> {
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