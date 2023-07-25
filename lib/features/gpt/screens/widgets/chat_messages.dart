import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';

import '../../../../models/messge_model.dart';
import '../../../../theme/pallete.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({
    super.key,
    required this.message,
  });

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Container(
            margin: const EdgeInsets.only(top: 5),
            child: BubbleSpecialThree(
              text: message.message,
              color: message.type == "bot"
                  ? Colors.white
                  : Pallete.purpleColor,
              tail: true,
              isSender: message.type == "bot" ? false : true,
              textStyle: TextStyle(
                color: message.type == "bot"
                    ? Colors.black
                    : Colors.white,
                fontSize: 14,
              ),
            ),
          );
  }
}
