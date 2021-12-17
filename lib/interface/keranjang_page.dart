import 'package:flutter/material.dart';
import 'package:kuaca_bali/widget/page_bar.dart';

class KeranjangPage extends StatelessWidget {
  const KeranjangPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
        child: Column(
          children: [
            const PageBar(
              mainPage: true,
              title: 'Keranjang',
            ),
            SizedBox(
              height: 350,
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.network(
                        'https://images.unsplash.com/photo-1614772903208-613ed4282ded?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80',
                        width: 130.0,
                        height: 130.0,
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
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
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
                            'Rp.3,200.000',
                            style: TextStyle(fontSize: 25),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
