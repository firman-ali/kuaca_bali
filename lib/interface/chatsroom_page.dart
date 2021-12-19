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
      home: ChatRoomPage(),
    );
  }
}

class ChatRoomPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
                Text(
                  'Nama User',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.home))
              ],
            ),
            SizedBox(height: 30),
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      child: CircleAvatar(
                        maxRadius: 40,
                        backgroundImage: NetworkImage(
                            'https://www.pngfind.com/pngs/m/93-938537_png-file-fa-user-circle-o-transparent-png.png'),
                      ),
                    ),
                    Text(
                      'Hai apa kabar ?',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Container(
                  child: CircleAvatar(
                    maxRadius: 40,
                    backgroundImage: NetworkImage(
                        'https://www.pngfind.com/pngs/m/93-938537_png-file-fa-user-circle-o-transparent-png.png'),
                  ),
                ),
                Text(
                  'Baik, bagaimana denganmu ?',
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
