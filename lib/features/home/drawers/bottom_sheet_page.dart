import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taqyeemi/features/home/drawers/widgets/suggestion_message.dart';
import 'package:taqyeemi/models/messge_model.dart';
import 'package:taqyeemi/theme/pallete.dart';

class BottomSheetPage extends ConsumerStatefulWidget {
  const BottomSheetPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BottomSheetPageState();
}

class _BottomSheetPageState extends ConsumerState<BottomSheetPage> {
  TextEditingController _textEditingController = TextEditingController();

  final messges = [
    MessageModel(message: "I`m TaqyeemiGPT, how can I help You?", type: "bot")
  ];

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    String message = _textEditingController.text;
    // Do something with the message, like sending it to a server or processing it.
    print("Message sent: $message");
    _textEditingController.clear();
  }

  void sendMessage(String message) {
    setState(() {
      messges.add(MessageModel(message: message, type: "user"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                "Ask TaqyeemiGPT",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),
              SuggestionMessage(
                  "whos the best instructor in the computer college?",
                  sendMessage),
              SuggestionMessage(
                  "whos the highest rated instructor?", sendMessage),
              SuggestionMessage(
                  "what is the best course in the computer college?",
                  sendMessage),
              SuggestionMessage(
                  "what is the highest rated course?", sendMessage),
              SuggestionMessage(
                  "what is the hardest course in the computer college?",
                  sendMessage),

              const SizedBox(height: 10),

              // list of messages
              Expanded(
                child: ListView.builder(
                  itemCount: messges.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(top: 5),
                      child: BubbleSpecialThree(
                        text: messges[index].message,
                        color: messges[index].type == "bot"
                            ? Colors.white
                            : Pallete.purpleColor,
                        tail: true,
                        isSender: messges[index].type == "bot" ? false : true,
                        textStyle: TextStyle(
                          color: messges[index].type == "bot"
                              ? Colors.black
                              : Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  cursorColor: Pallete.purpleColor,
                  style: TextStyle(color: Colors.black),
                  controller: _textEditingController,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    
                    hintText: "Ask TaqyeemiGPT",
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Pallete.purpleColor, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.grey)),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Icon button send message
              IconButton(
                onPressed: _textEditingController.text.isEmpty
                    ? null
                    : () {
                        sendMessage(_textEditingController.text);
                      },
                icon: Icon(
                  Icons.send,
                  size: 30,
                  color: _textEditingController.text.isEmpty
                      ? Colors.grey
                      : Pallete.purpleColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
