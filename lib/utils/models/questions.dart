class Question {
  List<Datum> data;
  String message;

  Question({
    required this.data,
    required this.message,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<Datum> dataList = list.map((i) => Datum.fromJson(i)).toList();

    return Question(
      data: dataList,
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((datum) => datum.toJson()).toList(),
      'message': message,
    };
  }
}

class Datum {
  int id;
  String questionType;

  Datum({
    required this.id,
    required this.questionType,
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json['id'],
      questionType: json['question_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question_type': questionType,
    };
  }
}