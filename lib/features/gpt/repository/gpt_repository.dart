import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:taqyeemi/features/course/controller/course_controller.dart';
import 'package:taqyeemi/features/instructor/controller/instructor_controller.dart';

final gptRepositoryProvider = Provider<GPTRepository>((ref) {
  return GPTRepository(
    ref: ref,
  );
});

class GPTRepository {
  Ref ref;
  GPTRepository({required this.ref});
  final List<Map<String, String>> messages = [];
  final String apiKey = dotenv.env["OPENAI_API_KEY"]!;

  void taqyeemiGPTInit() async {
    String instructorData = await ref
        .read(instructorControllerProvider.notifier)
        .getInstructorsDataFormated();
    String courseData = await ref
        .read(courseControllerProvider.notifier)
        .getCoursesDataFormated();

    String prompt = """    
                 you have new role now called taqyeemiGPT, you will be provided with data of instructors and courses.
               and people will ask you questions about them. you should answer them with the best answer you can.
                you can use the data provided to you to answer the questions. you should only answer the question
                no need to do long answer. just answer noted and be ready for questions

                heres an example of a question and answer:
                Q: what is the name of the instructor who teaches the course called flutter?
                A: the name of the instructor who teaches the course called flutter is ahmed
                Q: what is hardest course?
                A: the hardest course is physics

                heres the instructors data:
                $instructorData

                heres the courses data:
                $courseData
              """;
    messages.add({
      'role': 'system',
      'content': prompt,
    });

    final res = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({"model": "gpt-3.5-turbo", "messages": messages}),
    );
    if (res.statusCode == 200) {
      String content = jsonDecode(res.body)['choices'][0]['message']['content'];
      content = content.trim();
      messages.add({
        'role': 'assistant',
        'content': content,
      });
    }
  }

  void taqyeemiGPTClear() {
    messages.clear();
  }

  Future<String> taqyeemiGPTAsk(String messge) async {
    messages.add({
      'role': 'user',
      'content': messge,
    });
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": messages,
        }),
      );

      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();
        messages.add({
          'role': 'assistant',
          'content': content,
        });
        return content;
      }
      return Future(() => "Error in taqyeemiGPTAsk");
    } catch (e) {
      return Future(() => e.toString());
    }
  }
}
