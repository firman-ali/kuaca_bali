import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              height: 250.0,
              color: Colors.blue,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.network(
                            'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80',
                            width: 75.0,
                            height: 75.0,
                          ),
                          const Text(
                            'Welcome, User',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.home))
                    ],
                  ),
                  const Text(
                    'Cari Busana Adat Impianmu',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Cari Disini',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0))),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [ElevatedButton(onPressed: () {}, child: Text('filter'))],
          ),
          Expanded(
            child: GridView.builder(
                itemCount: 4,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 5.0),
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 200.0,
                        width: 500.0,
                        child: Stack(
                          children: [
                            Image.network(
                              'https://images.unsplash.com/photo-1542665174-31db64d7e0e4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=327&q=80',
                              width: 500.0,
                              height: 200.0,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              right: 0,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.bookmark,
                                    color: Colors.white,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Text('Nama Busana'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [Icon(Icons.store), Text('Nama Toko')],
                          ),
                          Row(
                            children: [Text('Rp'), Text('10.000/Hari')],
                          )
                        ],
                      ),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
