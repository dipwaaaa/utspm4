import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _startQuiz() {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Masukkan nama terlebih dahulu!'),
          backgroundColor: Colors.purple,
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizScreen(userName: _nameController.text.trim()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE8D5F2), Color(0xFFD5B8E8)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Quiz Icon with clouds
                Container(
                  width: size.width * 0.5,
                  height: size.width * 0.5,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.psychology,
                    size: size.width * 0.3,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: size.height * 0.04),

                // QUIZ Text
                Text(
                  'QUIZ',
                  style: TextStyle(
                    fontSize: size.width * 0.15,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFFA47BB8),
                    letterSpacing: 8,
                  ),
                ),
                SizedBox(height: size.height * 0.08),

                // Name Input
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _nameController,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: size.width * 0.045,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF8B5BA8),
                    ),
                    decoration: InputDecoration(
                      hintText: 'Masukkan nama kamu',
                      hintStyle: TextStyle(
                        color: const Color(0xFFB89CC9),
                        fontSize: size.width * 0.04,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: size.height * 0.025,
                        horizontal: size.width * 0.05,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.04),

                // Start Button
                CustomButton(
                  text: 'START',
                  onPressed: _startQuiz,
                  color: const Color(0xFFA47BB8),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}