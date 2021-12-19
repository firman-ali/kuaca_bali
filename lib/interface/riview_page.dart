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
      home: RiviewPage(),
    );
  }
}

class RiviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
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
                    'Riview',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text('Pesanamu :',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
              ],
            ),
            SizedBox(
              height: 8,
              width: 8,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Image.network(
                      'https://images.unsplash.com/photo-1614772903208-613ed4282ded?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80%27',
                      height: 130,
                      width: 130,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Nama Busana Adat',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.store,
                                color: Colors.blue,
                              ),
                              Text(
                                'Nama Toko',
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.house,
                                color: Colors.blue,
                              ),
                              Text(
                                'Jl Mandalasari No.19',
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                          Text(
                            'Rp.100,000/Hari',
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: List.generate(
                  150 ~/ 10,
                  (index) => Expanded(
                        child: Container(
                          color:
                              index % 2 == 0 ? Colors.transparent : Colors.grey,
                          height: 2,
                        ),
                      )),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Berikan Riview',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 40),
            TextField(
              showCursor: true,
              decoration: InputDecoration(
                  filled: true,
                  hintText: 'Tulis Riview',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0))),
            )
          ],
        ),
      ),
    );
  }
}
