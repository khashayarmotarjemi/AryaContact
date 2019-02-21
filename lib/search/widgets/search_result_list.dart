import 'package:arya_contact/common/loading.dart';
import 'package:arya_contact/search/address_search_bloc_provider.dart';
import 'package:arya_contact/search/address_search_repository.dart';
import 'package:arya_contact/search/widgets/search_result_list_item.dart';
import 'package:flutter/material.dart';

class SearchResultsList extends StatelessWidget {
  SearchResultsList();

  @override
  Widget build(BuildContext context) {
    var bloc = AddressSearchBlocProvider.of(context);

    return StreamBuilder<List<SearchResult>>(
        initialData: <SearchResult>[],
        stream: bloc.locations,
        builder: (context, resultSnapshot) {
          print("LENGHT: " + resultSnapshot.data.length.toString());
          return SizedBox(
              width: double.infinity,
              height: 380,
              child: Card(
                  margin: EdgeInsets.only(left: 7, right: 7, top: 7),
                  child: resultSnapshot.data.isNotEmpty
                      ? ListView.builder(
                          itemCount: resultSnapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            print("INDEX: " + index.toString());
                            return SearchResultItem(
                              onTap: () {
                                bloc.setResultVisibility.add(false);
                                bloc.search.add("");
                                bloc.select.add(resultSnapshot.data[index]);
                              },
                              result: resultSnapshot.data[index],
                            );
                          })
                      : LoadingSpinner()));
        });
  }
}
