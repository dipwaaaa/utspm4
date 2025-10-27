class Question {
  final String text;
  final List<String> options;
  final int correctAnswer;

  Question({
    required this.text,
    required this.options,
    required this.correctAnswer,
  });
}

List<Question> getQuestions() {
  return [
    Question(
      text: 'Kapan Stray Kids debut?',
      options: ['25 Maret 2018', '10 Oktober 2018', '16 November 2019', '15 November 2019'],
      correctAnswer: 0,
    ),
    Question(
      text: 'Ada berapa member Stray Kids saat ini?',
      options: ['6', '7', '8', '9'],
      correctAnswer: 2,
    ),
    Question(
      text: 'Siapa leader Stray Kids?',
      options: ['Bang Chan', 'Lee Kow', 'Hyunjin', 'Changbin'],
      correctAnswer: 0,
    ),
    Question(
      text: 'Kapan Stray Kids pertama kali menang di M Countdown?',
      options: ['5 Mei 2018', '4 April 2019', '10 Oktober 2018', '3 Oktober 2019'],
      correctAnswer: 1,
    ),
    Question(
      text: 'Apa album pertama Stray Kids?',
      options: ['Cle 1: Miroh', 'ODDINARY', 'GO LIVE', 'I Am: NOT'],
      correctAnswer: 3,
    ),
  ];
}