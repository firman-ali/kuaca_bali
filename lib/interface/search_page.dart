import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuaca_bali/database/firestore/db_service.dart';
import 'package:kuaca_bali/helper/state_helper.dart';
import 'package:kuaca_bali/provider/search_provider.dart';
import 'package:kuaca_bali/widget/page_bar.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
        child: Column(
          children: [
            const PageBar(mainPage: false, title: 'Search'),
            const SizedBox(height: 25.0),
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                labelText: 'Cari Disini',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              onSubmitted: (value) =>
                  Provider.of<SearchProvider>(context, listen: false)
                      .searchData(value),
            ),
            const SizedBox(height: 25.0),
            Expanded(
              child: Consumer<SearchProvider>(
                builder: (context, snapshot, child) {
                  if (snapshot.state == ResultState.hasData) {
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: snapshot.listData.length,
                      itemBuilder: (context, index) => searchItems(),
                    );
                  } else if (snapshot.state == ResultState.isWaiting) {
                    return Center(
                      child: Text(
                        'Cari Busana Adat',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    );
                  } else if (snapshot.state == ResultState.noData) {
                    return Center(
                      child: Text(
                        'Data yang dicari tidak ditemukan',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    );
                  } else if (snapshot.state == ResultState.isError) {
                    return Center(
                      child: Text(
                        'Terjadi Error',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget searchItems() {
    return Text('Ini Test');
  }
}
