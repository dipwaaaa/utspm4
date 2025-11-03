import 'package:flutter/material.dart';
import '../models/question.dart';
import '../widgets/custom_button.dart';
import '../widgets/option_card.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final String userName;

  const QuizScreen({super.key, required this.userName});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<Question> _questions = getQuestions();
  int _currentQuestionIndex = 0;
  int? _selectedAnswer;
  int _score = 0;
  final List<int?> _userAnswers = [];

  @override
  void initState() {
    super.initState();
    _userAnswers.addAll(List.filled(_questions.length, null));
  }

  void _selectAnswer(int index) {
    setState(() {
      _selectedAnswer = index;
      _userAnswers[_currentQuestionIndex] = index;
    });
  }

  void _nextQuestion() {
    if (_selectedAnswer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih jawaban terlebih dahulu!'),
          backgroundColor: Color(0xFFA47BB8),
        ),
      );
      return;
    }

    if (_selectedAnswer == _questions[_currentQuestionIndex].correctAnswer) {
      _score++;
    }

    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswer = _userAnswers[_currentQuestionIndex];
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            userName: widget.userName,
            score: _score,
            totalQuestions: _questions.length,
          ),
        ),
      );
    }
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
        _selectedAnswer = _userAnswers[_currentQuestionIndex];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final question = _questions[_currentQuestionIndex];
    final progress = (_currentQuestionIndex + 1) / _questions.length;

    return Scaffold(
      backgroundColor: const Color(0xFFE8D5F2),
      appBar: AppBar(
        title: Text(
          'Halo, ${widget.userName}!',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFA47BB8),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Progress Bar
          Container(
            height: 6,
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: const Color(0xFFD5B8E8),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFA47BB8)),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(size.width * 0.05),
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.02),

                    // Question Card with Number Badge
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(size.width * 0.06),
                      decoration: BoxDecoration(
                        color: const Color(0xFFB89CC9),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Number Badge
                          Container(
                            width: size.width * 0.12,
                            height: size.width * 0.12,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '0${_currentQuestionIndex + 1}',
                                style: TextStyle(
                                  fontSize: size.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFFA47BB8),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.02),

                          // Question Text
                          Text(
                            question.text,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: size.width * 0.045,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),

                    // Options
                    ...List.generate(
                      question.options.length,
                          (index) => OptionCard(
                        option: question.options[index],
                        index: index,
                        isSelected: _selectedAnswer == index,
                        onTap: () => _selectAnswer(index),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Navigation Buttons
          Container(
            padding: EdgeInsets.all(size.width * 0.05),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentQuestionIndex > 0)
                  SizedBox(
                    width: size.width * 0.35,
                    child: CustomButton(
                      text: 'BACK',
                      onPressed: _previousQuestion,
                      color: const Color(0xFFB89CC9),
                    ),
                  )
                else
                  SizedBox(width: size.width * 0.35),
                SizedBox(
                  width: size.width * 0.35,
                  child: CustomButton(
                    text: _currentQuestionIndex == _questions.length - 1
                        ? 'FINISH'
                        : 'NEXT',
                    onPressed: _nextQuestion,
                    color: const Color(0xFFA47BB8),
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