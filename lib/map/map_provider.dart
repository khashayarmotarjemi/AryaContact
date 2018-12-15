
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:maps_test/map/map_bloc.dart';

class MapBlocProvider extends StatefulWidget {
  final Widget child;
  final MapBloc bloc;

  MapBlocProvider({Key key, @required this.child, @required this.bloc})
      : super(key: key);

  @override
  _MapBlocProviderState createState() => _MapBlocProviderState();

  static MapBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_MapBlocProvider)
    as _MapBlocProvider)
        .bloc;
  }
}

class _MapBlocProviderState extends State<MapBlocProvider> {
  @override
  Widget build(BuildContext context) {
    return _MapBlocProvider(bloc: widget.bloc, child: widget.child);
  }

  @override
  void dispose() {
    widget.bloc.close();
    super.dispose();
  }
}

class _MapBlocProvider extends InheritedWidget {
  final MapBloc bloc;

  _MapBlocProvider({
    Key key,
    @required this.bloc,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_MapBlocProvider old) => bloc != old.bloc;
}