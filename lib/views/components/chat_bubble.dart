import 'package:chat_app/models/messages.dart';
import 'package:chat_app/utils/color.dart';
import 'package:chat_app/views/components/custom_text.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble(this.message, {Key? key}) : super(key: key);
  final Messages message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
            color: AppColors.primary),
        child: CustomText(
          text: message.message,
          color: Colors.white,
        ),
      ),
    );
  }
}

class MyChatBubble extends StatelessWidget {
  const MyChatBubble(this.message, {Key? key}) : super(key: key);
  final Messages message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomLeft: Radius.circular(32),
            ),
            color: Colors.deepOrange),
        child: CustomText(
          text: message.message,
          color: Colors.white,
        ),
      ),
    );
  }
}
