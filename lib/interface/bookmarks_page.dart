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
      home: BookmarksPage(),
    );
  }
}

class BookmarksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bookmarks',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 36.0),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.home))
                ],
              ),
            ),
            ListView.builder(
              itemBuilder: (context, index) {
                return keranjangitem();
              },
              itemCount: 1,
            )
          ],
        ),
      ),
    );
  }

  Container keranjangitem() {
    return Container(
      padding: EdgeInsets.all(10.0),
      height: 350,
      child: Column(
        children: [
          Row(
            children: [
              Image.network(
                'https://images.unsplash.com/photo-1614772903208-613ed4282ded?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80',
                //width: 130.0,
                //height: 130.0,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 25,
                      ),
                      Text(
                        '1/01/2021 - 4/01/2021',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  Text(
                    'Nama Busana Adat',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.store,
                        size: 25,
                      ),
                      Text(
                        'Nama Toko',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                  Text(
                    'Rp.100,000/Hari',
                    style: TextStyle(fontSize: 25),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
