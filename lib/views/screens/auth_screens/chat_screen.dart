import 'package:chat_app/models/messages.dart';
import 'package:chat_app/utils/color.dart';
import 'package:chat_app/views/components/chat_bubble.dart';
import 'package:chat_app/views/components/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);
  static String pageRoute = 'ChatPage';
  late String email;
  final _messageController = TextEditingController();
  CollectionReference messages =
      FirebaseFirestore.instance.collection('Messages');

  @override
  Widget build(BuildContext context) {
    email = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/chat.png', height: 50, width: 50),
            const CustomText(text: "Text Me !", fontFamily: 'Pacifico')
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: messages.orderBy('time', descending: true).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List messageList = [];

                    for (var i = 0; i < snapshot.data!.docs.length; i++) {
                      messageList
                          .add(Messages.fromJson(snapshot.data!.docs[i]));
                    }
                    return ListView.builder(
                        reverse: true,
                        itemCount: messageList.length,
                        itemBuilder: (context, index) {
                          if (email == messageList[index].id) {
                            return MyChatBubble(messageList[index]);
                          } else {
                            return ChatBubble(messageList[index]);
                          }
                        });
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                    onTap: () {
                      if (_messageController.text.isNotEmpty) {
                        messages.add({
                          "id": email,
                          "message": _messageController.text,
                          "time": DateTime.now()
                        });
                        _messageController.clear();
                      }
                    },
                    child: const Icon(Icons.send_rounded,
                        color: AppColors.primary)),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                hintText: 'write a message...',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
