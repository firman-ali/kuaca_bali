import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kuaca bali',
      theme: ThemeData(),
      home: HistoryPage(),
    );
  }
}

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            SafeArea(
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 30,
                      )),
                  Text(
                    'History',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ],
              ),
            ),
            ListView.builder(
              itemBuilder: (context, index) {
                return HistoryItem();
              },
              itemCount: 3,
            )
          ],
        ),
      ),
    );
  }

  Row HistoryItem() {
    return Row(
      children: [
        Image.network(
          'https://images.unsplash.com/photo-1614772903208-613ed4282ded?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80',
          width: 130,
          height: 130,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.access_time),
                Text('01/01/2021 - 04/01/2021'),
              ],
            ),
            Text('Nama Busana Adat'),
            Row(
              children: [Icon(Icons.store), Text('Nama Toko')],
            ),
            Text('Rp. 3,200,000'),
          ],
        ),
      ],
    );
  }
}
