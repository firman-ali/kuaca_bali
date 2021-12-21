import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kuaca_bali/common/colors.dart';
import 'package:kuaca_bali/database/auth/auth_service.dart';
import 'package:kuaca_bali/database/firestore/chat_service.dart';
import 'package:kuaca_bali/interface/chat_room_page.dart';
import 'package:kuaca_bali/model/user_data_model.dart';
import 'package:kuaca_bali/widget/custom_error_widget.dart';
import 'package:kuaca_bali/widget/menu_button.dart';
import 'package:kuaca_bali/widget/page_bar.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

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
              menuButton: MenuButtonChat(),
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
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream:
                    ChatService().getListChatStream(AuthService().getUserId()!),
                builder: (context, snapshot1) {
                  if (snapshot1.connectionState == ConnectionState.active) {
                    if (snapshot1.data!.docs.isNotEmpty) {
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: snapshot1.data?.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return chatTile(snapshot1, index);
                        },
                      );
                    } else {
                      return const CustomError(errorStatus: Status.empty);
                    }
                  }
                  return const CircularProgressIndicator();
                },
              ),
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
          .friendDataStream(snapshot1.data?.docs[index].data()["friendId"]),
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
                pushNewScreen(
                  context,
                  screen: ChatRoomPage(
                    roomId: snapshot1.data!.docs[index].id,
                    friendData: UserData.fromObject(snapshot2.data!),
                  ),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.scale,
                );
                if (unRead > 0) {
                  ChatService().readMsg(
                    AuthService().getUserId()!,
                    snapshot1.data!.docs[index].id,
                    snapshot1.data?.docs[index].data()["friendId"],
                  );
                }
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
                  title: Text(
                    snapshot2.data?.data()?["name"],
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  subtitle: snapshot2.data?.data()?["storeName"] != null
                      ? Row(
                          children: [
                            const Icon(Icons.store,
                                color: primary300, size: 20),
                            Text(
                              snapshot2.data?.data()?["storeName"],
                              style: Theme.of(context).textTheme.bodyText1,
                            )
                          ],
                        )
                      : null,
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
        return const Text('Ini snap 2 loading');
      },
    );
  }
}
