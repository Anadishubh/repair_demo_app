class Arrange {
  Data data;
  String message;

  Arrange({
    required this.data,
    required this.message,
  });
  factory Arrange.fromJson(Map<String, dynamic> json) => Arrange(
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
      };
}

class Data {
  String category;
  String subcategory;
  List<QuestionOrInformation> questionOrInformation;
  String childCategory;
  String questionType;

  Data({
    required this.category,
    required this.subcategory,
    required this.questionOrInformation,
    required this.childCategory,
    required this.questionType,
  });
  factory Data.fromJson(Map<String, dynamic> json) => Data(
        category: json["category"],
        subcategory: json["subcategory"],
        questionOrInformation: List<QuestionOrInformation>.from(
            json["question_or_information"]
                .map((x) => QuestionOrInformation.fromJson(x))),
        childCategory: json["child_category"],
        questionType: json["question_type"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "subcategory": subcategory,
        "question_or_information":
            List<dynamic>.from(questionOrInformation.map((x) => x.toJson())),
        "child_category": childCategory,
        "question_type": questionType,
      };
}

class QuestionOrInformation {
  String question;
  dynamic information;

  QuestionOrInformation({
    required this.question,
    required this.information,
  });
  factory QuestionOrInformation.fromJson(Map<String, dynamic> json) =>
      QuestionOrInformation(
        question: json["question"],
        information: json["information"],
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "information": information,
      };
}
