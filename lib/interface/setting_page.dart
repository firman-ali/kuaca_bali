import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Settings',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.home,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Text(
                'Profile Setings :',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Image.network(
                    'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80',
                    width: 130,
                    height: 130,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nama User',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                      Row(
                        children: [Icon(Icons.call), Text('No Telefon')],
                      ),
                      Row(
                        children: [
                          Icon(Icons.home),
                          Text('Jln. Sumpah Pemuda No.15')
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text('Tokoku',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            ],
          ),
          Row(
            children: [
              Icon(Icons.store),
              Text('Nama Toko',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))
            ],
          ),
          Row(
            children: [Icon(Icons.house), Text('Jln Sumpah Pemuda No.15')],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Buat Dagangan', style: TextStyle(fontSize: 25)),
              Icon(Icons.store)
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                'Preferance Settings',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Night Mode',
                style: TextStyle(fontSize: 20),
              ),
              Icon(Icons.power)
            ],
          )
        ],
      ),
    );
  }
}
