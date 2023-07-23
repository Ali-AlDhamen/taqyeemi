import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taqyeemi/core/core.dart';
import 'package:taqyeemi/features/gpt/screens/widgets/suggestion_message.dart';
import 'package:taqyeemi/models/messge_model.dart';
import 'package:taqyeemi/theme/pallete.dart';

import '../controller/gpt_controller.dart';

class TaqyeemiGPTScreen extends ConsumerStatefulWidget {
  const TaqyeemiGPTScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TaqyeemiGPTScreenState();
}

class _TaqyeemiGPTScreenState extends ConsumerState<TaqyeemiGPTScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  final messges = [
    MessageModel(message: "I`m TaqyeemiGPT, how can I help You?", type: "bot")
  ];

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void sendMessage(String message) async {
    setState(() {
      messges.add(MessageModel(message: message, type: "user"));
      _textEditingController.clear();
    });
    final gptMessage = await ref
        .read(gptControllerProvider.notifier)
        .taqyeemiGPTAsk((messges[messges.length - 1].message));
    setState(() {
      messges.add(MessageModel(message: gptMessage, type: "bot"));
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(gptControllerProvider);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        // bit darker white
        color: Color(0xffF2F2F2),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              children: [
                const Text(
                  "Ask TaqyeemiGPT",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                SuggestionMessage(
                  "Who is the best instructor?",
                  sendMessage,
                ),
                SuggestionMessage("How can I get a good grade in physics?", sendMessage),
                SuggestionMessage(
                    "Which course has highest average?", sendMessage),
                SuggestionMessage(
                    "What students think of Ali AlDhamen?", sendMessage),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: messges.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(top: 5),
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
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    cursorColor: Pallete.purpleColor,
                    style: const TextStyle(color: Colors.black),
                    controller: _textEditingController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      hintText: "Ask TaqyeemiGPT",
                      hintStyle: const TextStyle(color: Colors.grey),
                      contentPadding: const EdgeInsets.symmetric(
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
                          borderSide: const BorderSide(color: Colors.grey)),
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
                  icon: isLoading
                      ? const Loader(
                          color: Pallete.purpleColor,
                        )
                      : Icon(
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
      ),
    );
  }
}