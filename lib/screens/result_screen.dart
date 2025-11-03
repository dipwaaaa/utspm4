import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import 'home_screen.dart';

class ResultScreen extends StatelessWidget {
  final String userName;
  final int score;
  final int totalQuestions;

  const ResultScreen({
    super.key,
    required this.userName,
    required this.score,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final percentage = (score / totalQuestions * 100).round();

    String message;
    IconData icon;

    if (percentage >= 80) {
      message = 'Luar Biasa! 🎉';
      icon = Icons.emoji_events;
    } else if (percentage >= 60) {
      message = 'Bagus! 👍';
      icon = Icons.thumb_up;
    } else {
      message = 'Semangat! 💪';
      icon = Icons.emoji_emotions;
    }

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
            padding: EdgeInsets.all(size.width * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Trophy Icon
                Container(
                  width: size.width * 0.35,
                  height: size.width * 0.35,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: size.width * 0.2,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: size.height * 0.03),

                // Message
                Text(
                  message,
                  style: TextStyle(
                    fontSize: size.width * 0.08,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: size.height * 0.04),

                // Result Card
                Container(
                  width: size.width * 0.85,
                  padding: EdgeInsets.all(size.width * 0.08),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 30,
                        offset: const Offset(0, 15),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // User Name
                      Text(
                        userName,
                        style: TextStyle(
                          fontSize: size.width * 0.06,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF8B5BA8),
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),

                      // Score Circle
                      Container(
                        width: size.width * 0.45,
                        height: size.width * 0.45,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFFE8D5F2), Color(0xFFB89CC9)],
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFA47BB8).withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$score',
                                style: TextStyle(
                                  fontSize: size.width * 0.15,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF8B5BA8),
                                ),
                              ),
                              Text(
                                'dari $totalQuestions',
                                style: TextStyle(
                                  fontSize: size.width * 0.04,
                                  color: const Color(0xFFA47BB8),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),

                      // Percentage
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.06,
                          vertical: size.height * 0.015,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8D5F2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Persentase: $percentage%',
                          style: TextStyle(
                            fontSize: size.width * 0.045,
                            color: const Color(0xFF8B5BA8),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.04),

                      // Play Again Button
                      CustomButton(
                        text: 'MAIN LAGI',
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                                (route) => false,
                          );
                        },
                        color: const Color(0xFFA47BB8),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}