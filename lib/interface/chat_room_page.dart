import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kuaca_bali/common/colors.dart';
import 'package:kuaca_bali/database/auth/auth_service.dart';
import 'package:kuaca_bali/database/firestore/chat_service.dart';
import 'package:kuaca_bali/helper/date_helper.dart';
import 'package:kuaca_bali/model/list_room_chat.dart';
import 'package:kuaca_bali/model/user_data_model.dart';
import 'package:kuaca_bali/widget/page_bar.dart';

class ChatRoomPage extends StatelessWidget {
  const ChatRoomPage({Key? key, required this.roomId, required this.friendData})
      : super(key: key);
  final String roomId;
  final UserData friendData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: primary100,
        body: Column(
          children: [
            PageBar(mainPage: false, title: friendData.name),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: ChatService().fetchChatDataStream(roomId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    return ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) => chatItems(
                        context,
                        ListRoomChat.fromObject(snapshot.data!.docs[index]),
                      ),
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
        bottomSheet: ButtomChatField(roomId: roomId, friendData: friendData),
      ),
    );
  }

  Widget chatItems(BuildContext context, ListRoomChat data) {
    final aligment = data.fromId == AuthService().getUserId()
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: aligment,
        children: [
          Text(
            DateHelper.formatDateTime(data.cretaedAt),
            style: Theme.of(context).textTheme.bodyText2,
          ),
          Text(
            data.msg,
            style:
                Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 20),
          ),
        ],
      ),
    );
  }
}

class ButtomChatField extends StatefulWidget {
  const ButtomChatField({
    Key? key,
    required this.roomId,
    required this.friendData,
  }) : super(key: key);

  final String roomId;
  final UserData friendData;

  @override
  State<ButtomChatField> createState() => _ButtomChatFieldState();
}

class _ButtomChatFieldState extends State<ButtomChatField> {
  final TextEditingController chatController = TextEditingController();

  @override
  void dispose() {
    chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primary100,
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: chatController,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(),
                  ),
                  hintText: 'Tulis Pesan Disini',
                  hintStyle: Theme.of(context).textTheme.caption),
            ),
          ),
          IconButton(
            onPressed: () async {
              await ChatService().addMessage(
                chatController.text,
                widget.roomId,
                widget.friendData.id!,
              );
              chatController.clear();
              FocusScope.of(context).unfocus();
            },
            icon: const Icon(Icons.send),
          )
        ],
      ),
    );
  }
}
