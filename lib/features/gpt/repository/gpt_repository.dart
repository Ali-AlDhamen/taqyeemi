import 'package:dart_openai/dart_openai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taqyeemi/features/auth/controller/auth_controller.dart';
import 'package:taqyeemi/features/course/controller/course_controller.dart';
import 'package:taqyeemi/features/course/repository/course_repository.dart';
import 'package:taqyeemi/features/instructor/controller/instructor_controller.dart';
import 'package:taqyeemi/features/instructor/repository/instructor_repository.dart';
import 'package:taqyeemi/models/course_comment_model.dart';
import 'package:taqyeemi/models/instructor_comment_model.dart';
import 'package:uuid/uuid.dart';

final gptRepositoryProvider = Provider<GPTRepository>((ref) {
  return GPTRepository(
    ref: ref,
  );
});

class GPTRepository {
  void addComment({
    required String instructorName,
    required String? comment,
    required String courseGrade,
    required int teaching,
    required int grading,
    required int treating,
    required int attendance,
    required String courseCode,
  }) async {
    final userId = ref.read(userProvider)!.userId;
    InstructorComment instructorComment = InstructorComment(
      id: const Uuid().v4(),
      instructorId: instructorName,
      userId: userId,
      courseGrade: courseGrade,
      comment: comment,
      teaching: teaching,
      grading: grading,
      treating: treating,
      attendance: attendance,
      courseCode: courseCode,
      date: DateTime.now(),
    );

    final InstructorRepository instructorRepository =
        ref.read(instructorRepositoryProvider);

    await instructorRepository.addComment(instructorComment);
  }

  void addCourseComment(String grade, String comment, String diffuclty,
      String courseName, String courseCode) async {
    final user = ref.read(userProvider)!;

    CourseComment courseComment = CourseComment(
      id: "$courseCode${DateTime.now()}",
      comment: comment,
      difficulty: diffuclty,
      grade: grade,
      userId: user.userId,
      courseId: courseCode,
      date: DateTime.now(),
    );
    final CourseRepository courseRepository =
        ref.read(courseRepositoryProvider);
    await courseRepository.addComment(courseComment, courseName);
  }

  Ref ref;
  GPTRepository({required this.ref});
  List<OpenAIChatCompletionChoiceMessageModel> messages = [];
  final String apiKey = dotenv.env["OPENAI_API_KEY"]!;

  void taqyeemiGPTInit() async {
    OpenAI.apiKey = apiKey;
    String instructorData = await ref
        .read(instructorControllerProvider.notifier)
        .getInstructorsDataFormatted();
    String courseData = await ref
        .read(courseControllerProvider.notifier)
        .getCoursesDataFormatted();

    String prompt = """
    As taqyeemiGPT, you are designed to respond to user inquiries about courses and instructors. 
    When a user asks for information, provide answers based on the available data (instructorData and courseData).
     please always answer from data provided to you,
    like if someone ask how do i get good grade in some course or 
    how do i secure A+ in course look for the course comments in the data and answer from it (don't add anything else just summarize it please keep it short)
    If the user expresses a desire to rate a course or instructor, you will initiate a function call to process their rating.

    Example user messages that should trigger the rating function include:
    - "I would like to rate a course"
    - "Please rate this course for me"
    - Any similar request for course rating.


    Instructor Data:
    $instructorData

    Course Data:
    $courseData

   
    Ensure you understand and extract the user's intent and required arguments
    from their message before calling the rating function.
    """;

    messages.add(
      OpenAIChatCompletionChoiceMessageModel(
        content: prompt,
        role: OpenAIChatMessageRole.system,
      ),
    );

    // final chat = await OpenAI.instance.chat.create(
    //   model: "gpt-3.5-turbo",
    //   messages: messages,
    // );
    // print(chat.choices.first.message);
    // messages.add(
    //   OpenAIChatCompletionChoiceMessageModel(
    //       content: chat.choices.first.message.toString(),
    //       role: OpenAIChatMessageRole.assistant),
    // );
  }

  void taqyeemiGPTClear() {
    messages.clear();
  }

  Future<String> taqyeemiGPTAsk(String messge) async {
    try {
      final addInstructorCommentTool = OpenAIFunctionModel.withParameters(
        name: "addInstructorComment",
        description:
            "Add a comment about an instructor. All parameters are required, except for 'comment' which is optional. Please include teaching, grading, treating, attendance, courseCode, and courseGrade.",
        parameters: [
          OpenAIFunctionProperty.string(
            isRequired: true,
            name: "instructorName",
            description:
                "The name of the instructor to add the comment to. Very important",
          ),
          OpenAIFunctionProperty.integer(
            isRequired: true,
            name: "teaching",
            description:
                "The teaching rating for the instructor. Very important (10..20..100 ) inc by 10 only",
          ),
          OpenAIFunctionProperty.integer(
            isRequired: true,
            name: "grading",
            description:
                "The grading rating for the instructor. Very important (10..20..100) inc by 10 only",
          ),
          OpenAIFunctionProperty.integer(
            isRequired: true,
            name: "treating",
            description:
                "The treating rating for the instructor. Very important (10..20..100) inc by 10 only",
          ),
          OpenAIFunctionProperty.integer(
            isRequired: true,
            name: "attendance",
            description:
                "The attendance rating for the instructor. Very important (10..20..100) inc by 10 only",
          ),
          OpenAIFunctionProperty.string(
            isRequired: true,
            name: "courseCode",
            description:
                "The code of the course associated with this comment. Very important",
          ),
          OpenAIFunctionProperty.string(
            isRequired: true,
            name: "courseGrade",
            description: "The grade received in the course. Very important",
            enumValues: [
              "F",
              "D",
              "D+",
              "C",
              "C+",
              "B",
              "B+",
              "A",
              "A+",
            ],
          ),
          OpenAIFunctionProperty.string(
            isRequired: false,
            name: "comment",
            description: "An optional comment about the instructor",
          ),
        ],
      );
      final addCourseCommentTool = OpenAIFunctionModel.withParameters(
        name: "addCourseComment",
        description:
            "add a comment to a course",
        parameters: [
          OpenAIFunctionProperty.string(
            isRequired: true,
            name: "grade",
            description: "The grade given by the user",
            enumValues: [
              "F",
              "D",
              "D+",
              "C",
              "C+",
              "B",
              "B+",
              "A",
              "A+",
            ],
          ),
          OpenAIFunctionProperty.string(
            isRequired: true,
            name: "comment",
            description: "The comment about the course",
          ),
          OpenAIFunctionProperty.string(
            isRequired: true,
            name: "difficulty",
            description: "The difficulty level of the course",
            enumValues: [
              "Super Easy",
              "Easy",
              "Medium",
              "Hard",
              "Super Hard",
            ],
          ),
          OpenAIFunctionProperty.string(
            isRequired: true,
            name: "courseName",
            description:
                "The name of the course to add the comment to",
          ),
          OpenAIFunctionProperty.string(
            isRequired: true,
            name: "courseCode",
            description:
                "The code of the course to add the comment to",
          ),
        ],
      );

      final userMessage = OpenAIChatCompletionChoiceMessageModel(
        content: messge,
        role: OpenAIChatMessageRole.user,
      );
      messages.add(userMessage);

      final chat = await OpenAI.instance.chat.create(
        model: "gpt-3.5-turbo-16k",
        messages: messages,
        functions: [addCourseCommentTool, addInstructorCommentTool],
      );

      print(chat);

// Handling the response and function calling.
      final message = chat.choices.first.message;
      print(chat);

      if (message.hasFunctionCall) {
        final call = message.functionCall!;
        print(call);
        print("-------");
        print(call.arguments!);
        if (call.name == "addCourseComment") {
          // Decode the arguments from the tool call.
          final decodedArgs = call.arguments!;

          final String grade = decodedArgs["grade"];
          final String comment = decodedArgs["comment"];
          final String difficulty = decodedArgs["difficulty"];
          final String courseName = decodedArgs["courseName"];
          final String courseCode = decodedArgs["courseCode"];

          // Call the function with the arguments.
          addCourseComment(grade, comment, difficulty, courseName, courseCode);
          return "added the comment to the $courseName course";
        }

        if (call.name == "addInstructorComment") {
          // Decode the arguments from the tool call.
          final decodedArgs = call.arguments!;
          final String name = decodedArgs["instructorName"];
          final int teaching = decodedArgs["teaching"].toInt();
          final int grading = decodedArgs["grading"].toInt();
          final int treating = decodedArgs["treating"].toInt();
          final int attendance = decodedArgs["attendance"].toInt();
          final String courseCode = decodedArgs["courseCode"] ?? "";
          final String courseGrade = decodedArgs["courseGrade"] ?? "";
          final String comment = decodedArgs["comment"];

          // Call the function with the arguments.
          addComment(
            instructorName: name,
            comment: comment,
            courseGrade: courseGrade,
            teaching: teaching,
            grading: grading,
            treating: treating,
            attendance: attendance,
            courseCode: courseCode,
          );
          return "added the comment to the $name";
        }
      }
      messages.add(
        OpenAIChatCompletionChoiceMessageModel(
          content: chat.choices.first.message.content.toString(),
          role: OpenAIChatMessageRole.assistant,
        ),
      );
      return chat.choices.first.message.content;
    } catch (e) {
      return Future(() => "Sorry, Something went wrong, please try again");
    }
  }
}
