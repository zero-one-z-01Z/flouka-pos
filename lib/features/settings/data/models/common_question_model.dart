import '../../domain/entities/common_question_entity.dart';

class CommonQuestionModel extends CommonQuestionEntity {
  const CommonQuestionModel(
      {required super.id,
        required super.title,
        required super.faq,
      });

  factory CommonQuestionModel.fromJson(Map data) {
    List<FaqModel> faqList =[];
    for (var element in data['faq']){
      faqList.add(FaqModel.fromJson(element));
    }
    return CommonQuestionModel(
      id: data['id'],
      title: data['name'],
      faq: faqList,
    );
  }
}
class FaqModel extends FaqEntity {
  const FaqModel(
      {required super.id,
      required super.answer,
        required super.question,
      });

  factory FaqModel.fromJson(Map data) {
    return FaqModel(
      id: data['id'],
      answer: data['answer'],
      question: data['question'],
    );
  }
}