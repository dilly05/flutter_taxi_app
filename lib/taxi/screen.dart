import 'package:flutter/material.dart';
import 'package:flutter_taxi_app/taxi/cal_screen.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFD700),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 400,
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Image.asset('assets/images/taxi.png', width: 150),
                      const SizedBox(height: 20),
                      const Text(
                        'TAXI METER',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      const Text(
                        'THAI FARE CALCULATOR',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 30),
                      const CircularProgressIndicator(
                        color: Colors.green,
                        strokeWidth: 3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Column(
              children: [
                const Text(
                  'ID: 6XXXXXXXXX',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const Text(
                  'NAME: XXXX YYYYYYYYY',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CalScreen()),
                    );
                  },
                  child: const Text('เริ่มใช้งาน'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
