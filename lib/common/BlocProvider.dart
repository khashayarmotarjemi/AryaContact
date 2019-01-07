import 'package:flutter/widgets.dart';

class BlocProvider<B> extends StatefulWidget {
  final Widget child;
  final B bloc;

  BlocProvider({Key key, @required this.child, @required this.bloc})
      : super(key: key);

  @override
  _BlocProviderState createState() => _BlocProviderState();

  static B of<B>(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_BlocProvider)
    as _BlocProvider)
        .bloc;
  }
}

class _BlocProviderState<B> extends State<BlocProvider> {
  @override
  Widget build(BuildContext context) {
    return _BlocProvider<B>(bloc: widget.bloc, child: widget.child);
  }

  @override
  void dispose() {
    widget.bloc.close();
    super.dispose();
  }
}

class _BlocProvider<B> extends InheritedWidget {
  final B bloc;

  _BlocProvider({
    Key key,
    @required this.bloc,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_BlocProvider old) => bloc != old.bloc;
}