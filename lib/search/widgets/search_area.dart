import 'package:arya_contact/search/address_search_bloc.dart';
import 'package:arya_contact/search/address_search_bloc_provider.dart';
import 'package:arya_contact/search/widgets/search_bar.dart';
import 'package:arya_contact/search/widgets/search_result_list.dart';
import 'package:flutter/material.dart';

class SearchArea extends StatelessWidget {
  AddressSearchBloc _searchBloc;

  @override
  Widget build(BuildContext context) {
    _searchBloc = AddressSearchBlocProvider.of(context);

    return StreamBuilder<bool>(
        stream: _searchBloc.resultVisibility,
        builder: (context, visibilitySnapshot) {
          return Column(children: <Widget>[
            SearchBar(),
            visibilitySnapshot.hasData && visibilitySnapshot.data
                ? SearchResultsList()
                : Container()
          ]);
        });
  }
}
