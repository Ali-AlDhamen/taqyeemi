import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';

import '../../../../models/messge_model.dart';
import '../../../../theme/pallete.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({
    super.key,
    required this.messages,
  });

  final List<MessageModel> messages;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(top: 5),
            child: BubbleSpecialThree(
              text: messages[index].message,
              color: messages[index].type == "bot"
                  ? Colors.white
                  : Pallete.purpleColor,
              tail: true,
              isSender: messages[index].type == "bot" ? false : true,
              textStyle: TextStyle(
                color: messages[index].type == "bot"
                    ? Colors.black
                    : Colors.white,
                fontSize: 14,
              ),
            ),
          );
        },
      ),
    );
  }
}
