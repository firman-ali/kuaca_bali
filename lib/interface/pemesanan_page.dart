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
      home: PemesananPage(),
    );
  }
}

class PemesananPage extends StatelessWidget {
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
                    'Pemesanan',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.network(
                        'https://images.unsplash.com/photo-1614772903208-613ed4282ded?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80%27',
                        width: 130,
                        height: 130,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Nama Busana Adat',
                                style: TextStyle(fontSize: 25),
                              ),
                            ],
                          ),
                          Row(
                            children: [Icon(Icons.store), Text('Nama Toko')],
                          ),
                          Row(
                            children: [
                              Icon(Icons.house),
                              Text('Jl.Mandalsari No.19')
                            ],
                          ),
                          Text('Rp.100,000/Hari')
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
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
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rincian Pesanan',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  Row(
                    children: [
                      Image.network(
                        'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80',
                        width: 60,
                        height: 60,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Nama user',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.home),
                              Text(
                                'Jl Drupadi No.20',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pembayaran',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        Row(
                          children: [
                            Text(
                              'Metode Pembayaran :',
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: List.generate(
                        150 ~/ 10,
                        (index) => Expanded(
                              child: Container(
                                color: index % 2 == 0
                                    ? Colors.transparent
                                    : Colors.grey,
                                height: 2,
                              ),
                            )),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Detail Pemesanan',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Tanggal Pemesanan',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    '01/01/2021 - 04/01/2021',
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Ukuran Pakian : M',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Total Pesanan :',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Rp.3,200.000',
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
