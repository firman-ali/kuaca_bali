import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: Container(
              height: 450.0,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Stack(
                              children: [
                                Image.network(
                                  'https://images.unsplash.com/photo-1627511306341-f9d96646b91d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                                  width: 600.0,
                                ),
                                Positioned(
                                  left: 0,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.home,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.bookmark,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
