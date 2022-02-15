class RepeatedQuestions {
  Data? data;

  RepeatedQuestions.fromJson(Map json) {
    data = Data.fromJson(json['data']);
  }
}

class Data {
  List data = [];

  Data.fromJson(json) {
    json['data'].forEach((element) {
      data.add(RepeatedQuestionsData.fromJson(element));
    });
  }
}

class RepeatedQuestionsData {
  int? id;

  String? question;

  String? answer;

  RepeatedQuestionsData.fromJson(Map json) {
    id = json['id'];
    question= json['question'];
    answer = json['answer'];
  }
}
