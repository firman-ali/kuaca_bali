import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SafeArea(
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 35.0,
                      )),
                  Text(
                    'Search',
                    style:
                        TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            SizedBox(height: 25.0),
            TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Cari Disini',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0))),
            ),
          ],
        ),
      ),
    );
  }
}
