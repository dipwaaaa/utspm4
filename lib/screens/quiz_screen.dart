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
        const SnackBar(content: Text('Pilih jawaban terlebih dahulu!')),
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
      appBar: AppBar(
        title: Text('Halo, ${widget.userName}!'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.shade200,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            minHeight: 8,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(size.width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pertanyaan ${_currentQuestionIndex + 1}/${_questions.length}',
                      style: TextStyle(
                        fontSize: size.width * 0.04,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(size.width * 0.05),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        question.text,
                        style: TextStyle(
                          fontSize: size.width * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
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
          Container(
            padding: EdgeInsets.all(size.width * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentQuestionIndex > 0)
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: size.width * 0.02),
                      child: CustomButton(
                        text: 'Sebelumnya',
                        onPressed: _previousQuestion,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: _currentQuestionIndex > 0 ? size.width * 0.02 : 0,
                    ),
                    child: CustomButton(
                      text: _currentQuestionIndex == _questions.length - 1
                          ? 'Selesai'
                          : 'Selanjutnya',
                      onPressed: _nextQuestion,
                    ),
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