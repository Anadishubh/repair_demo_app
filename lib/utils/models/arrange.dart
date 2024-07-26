// class Questionlist {
//     Question2 data;
//     String message;

//     Questionlist({
//         required this.data,
//         required this.message,
//     });
//     factory Questionlist.fromJson(Map<String, dynamic> json) => Questionlist(
//         data: Question2.fromJson(json["data"]),
//         message: json["message"],
//     );

//     Map<String, dynamic> toJson() => {
//         "data": data.toJson(),
//         "message": message,
//     };
// }

// class Question2 {
//     String category;
//     String subcategory;
//     List<QuestionOrInformation> questionOrInformation;
//     String childCategory;
//     String questionType;

//     Question2({
//         required this.category,
//         required this.subcategory,
//         required this.questionOrInformation,
//         required this.childCategory,
//         required this.questionType,
//     });

//     factory Question2.fromJson(Map<String, dynamic> json) => Question2(
//         category: json["category"],
//         subcategory: json["subcategory"],
//         questionOrInformation: List<QuestionOrInformation>.from(json["question_or_information"].map((x) => QuestionOrInformation.fromJson(x))),
//         childCategory: json["child_category"],
//         questionType: json["question_type"],
//     );

//     Map<String, dynamic> toJson() => {
//         "category": category,
//         "subcategory": subcategory,
//         "question_or_information": List<dynamic>.from(questionOrInformation.map((x) => x.toJson())),
//         "child_category": childCategory,
//         "question_type": questionType,
//     };
// }

// class QuestionOrInformation {
//     String question;
//     dynamic information;

//     QuestionOrInformation({
//         required this.question,
//         required this.information,
//     });

//     factory QuestionOrInformation.fromJson(Map<String, dynamic> json) => QuestionOrInformation(
//         question: json["question"],
//         information: json["information"],
//     );

//     Map<String, dynamic> toJson() => {
//         "question": question,
//         "information": information,
//     };
// }
// models/question_model.dart
class QuestionModel {
  final String question;

  QuestionModel({required this.question});

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      question: json['question'] ?? '',
    );
  }
}
