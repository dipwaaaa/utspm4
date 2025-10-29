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
    Color color;
    IconData icon;

    if (percentage >= 80) {
      message = 'Luar Biasa!';
      color = Colors.green;
      icon = Icons.emoji_events;
    } else if (percentage >= 60) {
      message = 'Bagus!';
      color = Colors.blue;
      icon = Icons.thumb_up;
    } else {
      message = 'Semangat!';
      color = Colors.orange;
      icon = Icons.emoji_emotions;
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [color.shade300, color.shade700],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(size.width * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: size.width * 0.3,
                  color: Colors.white,
                ),
                SizedBox(height: size.height * 0.03),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: size.width * 0.08,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Container(
                  width: size.width * 0.85,
                  padding: EdgeInsets.all(size.width * 0.06),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text(
                        userName,
                        style: TextStyle(
                          fontSize: size.width * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Text(
                        'Skor Akhir',
                        style: TextStyle(
                          fontSize: size.width * 0.045,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '$score',
                            style: TextStyle(
                              fontSize: size.width * 0.15,
                              fontWeight: FontWeight.bold,
                              color: color,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: size.width * 0.03),
                            child: Text(
                              '/$totalQuestions',
                              style: TextStyle(
                                fontSize: size.width * 0.06,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.01),
                      Text(
                        'Persentase: $percentage%',
                        style: TextStyle(
                          fontSize: size.width * 0.045,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      CustomButton(
                        text: 'Main Lagi',
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                                (route) => false,
                          );
                        },
                        color: color,
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