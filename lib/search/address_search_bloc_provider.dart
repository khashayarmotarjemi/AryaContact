import 'package:arya_contact/search/address_search_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddressSearchBlocProvider extends StatefulWidget {
  final Widget child;
  final AddressSearchBloc bloc;

  AddressSearchBlocProvider(
      {Key key, @required this.child, @required this.bloc})
      : super(key: key);

  @override
  _AddressSearchBlocProviderState createState() =>
      _AddressSearchBlocProviderState();

  static AddressSearchBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_AddressSearchBlocProvider)
            as _AddressSearchBlocProvider)
        .bloc;
  }
}

class _AddressSearchBlocProviderState extends State<AddressSearchBlocProvider> {
  @override
  Widget build(BuildContext context) {
    return _AddressSearchBlocProvider(bloc: widget.bloc, child: widget.child);
  }

  @override
  void dispose() {
    widget.bloc.close();
    super.dispose();
  }
}

class _AddressSearchBlocProvider extends InheritedWidget {
  final AddressSearchBloc bloc;

  _AddressSearchBlocProvider({
    Key key,
    @required this.bloc,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_AddressSearchBlocProvider old) => bloc != old.bloc;
}
