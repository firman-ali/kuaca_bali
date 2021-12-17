import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kuaca_bali/common/colors.dart';
import 'package:kuaca_bali/database/firestore/chat_service.dart';
import 'package:kuaca_bali/widget/page_bar.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
        child: Column(
          children: [
            const PageBar(
              mainPage: true,
              title: 'Chats',
            ),
            const SizedBox(height: 25.0),
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                labelText: 'Cari Pemilik Toko',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: ChatService().getListChat("M5m9i8Pkjih2RTgUbXGkCiHAl5x1"),
              builder: (context, snapshot1) {
                if (snapshot1.connectionState == ConnectionState.active) {
                  return Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: snapshot1.data?.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return chatTile(snapshot1, index);
                      },
                    ),
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget chatTile(
      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot1, int index) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: ChatService()
          .friendData(snapshot1.data?.docs[index].data()["friendId"]),
      builder: (context, snapshot2) {
        if (snapshot2.connectionState == ConnectionState.active) {
          final date = DateTime.now()
              .difference(
                DateTime.fromMicrosecondsSinceEpoch(
                  snapshot1.data?.docs[index]
                      .data()["updatedAt"]
                      .microsecondsSinceEpoch,
                ),
              )
              .inMinutes;
          final unRead = snapshot1.data?.docs[index].data()["unRead"] as int;

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            child: InkWell(
              onTap: () {
                print(snapshot1.data?.docs[index].id);
              },
              child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 5,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 10.0,
                  ),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      snapshot2.data?.data()?["imageUrl"] ??
                          "https://images.unsplash.com/photo-1578468336165-edaf27927e0f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
                    ),
                    radius: 30,
                  ),
                  title: Text(snapshot2.data?.data()?["name"]),
                  trailing: unRead > 0
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(date.toString() + " Min"),
                            Container(
                              width: 20,
                              height: 20,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: secondary300,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Text(
                                unRead.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(color: onSecondary),
                              ),
                            )
                          ],
                        )
                      : const SizedBox(),
                ),
              ),
            ),
          );
        }
        return Text('Ini snap 2 loading');
      },
    );
  }
}
