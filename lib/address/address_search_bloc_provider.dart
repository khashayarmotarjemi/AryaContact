import 'package:arya_contact/address/address_search_bloc.dart';
import 'package:arya_contact/contact/contact_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddressSearchBlocProvider extends StatefulWidget {
  final Widget child;
  final AddressSearchBloc bloc;

  AddressSearchBlocProvider({Key key, @required this.child, @required this.bloc})
      : super(key: key);

  @override
  _AddressSearchBlocProviderState createState() => _AddressSearchBlocProviderState();

  static ContactBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_ContactBlocProvider)
            as _ContactBlocProvider)
        .bloc;
  }
}

class _AddressSearchBlocProviderState extends State<AddressSearchBlocProvider> {
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
