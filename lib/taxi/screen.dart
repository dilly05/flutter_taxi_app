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
      // ใช้สีเหลือง Amber ตามรูป
      backgroundColor: const Color(0xFFFFD700),
      body: Stack(
        children: [
          // 1. ส่วนเนื้อหาตรงกลาง
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // กรอบสีขาวมนๆ ตรงกลาง
                Container(
                  width: 400,
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3), // ขาวจางๆ
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      // รูป Icon Taxi (แนะนำให้ใช้ Image.asset ถ้ามีไฟล์)
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
                      // Loading Icon จางๆ
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

          // 2. ส่วนข้อมูลผู้จัดทำ (ชิดขอบล่าง)
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
                // ปุ่มกดเพื่อไปหน้าคำนวณ (หรือจะใช้ Timer สั่งไปเองก็ได้)
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const CalScreen()), // ใส่ชื่อ Class ของหน้าคำนวณ
                    );
                  },
                  // ... style อื่นๆ เหมือนเดิม ...
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
