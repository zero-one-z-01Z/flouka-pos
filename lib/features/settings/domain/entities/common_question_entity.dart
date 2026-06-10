class CommonQuestionEntity {
  final int id;
  final String title;
  final List<FaqEntity> faq;

  const CommonQuestionEntity({
    required this.id,
    required this.title,
    required this.faq,
  });
}

class FaqEntity {
  final int id;
  final String question;
  final String answer;

  const FaqEntity({
    required this.id,
    required this.answer,
    required this.question,
  });
}
