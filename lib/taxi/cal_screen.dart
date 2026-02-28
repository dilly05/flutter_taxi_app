import 'package:flutter/material.dart';

class CalScreen extends StatefulWidget {
  const CalScreen({super.key});

  @override
  State<CalScreen> createState() => _CalScreenState();
}

class _CalScreenState extends State<CalScreen> {
  // --- ส่วน Logic (เหมือนเดิม) ---
  final TextEditingController distCtrl = TextEditingController();
  final TextEditingController timeCtrl = TextEditingController();

  double totalFare = 0;
  double distFareOnly = 0;
  double timeFareOnly = 0;

  void calculateTaxiFare() {
    double distance = double.tryParse(distCtrl.text) ?? 0;
    int minutes = int.tryParse(timeCtrl.text) ?? 0;

    if (distance <= 0) return;

    double fare = 35.0; // Base
    double remainingDist = distance - 1;

    if (remainingDist > 0) {
      double d = remainingDist > 9 ? 9 : remainingDist;
      fare += d * 6.50;
      remainingDist -= d;
    }
    if (remainingDist > 0) {
      double d = remainingDist > 10 ? 10 : remainingDist;
      fare += d * 7.00;
      remainingDist -= d;
    }
    // ... (กม.ที่ 20-40, 40-60, 60-80 เพิ่มเติมได้ตามสูตรเดิม) ...

    double tFare = minutes * 3.0;

    setState(() {
      distFareOnly = fare;
      timeFareOnly = tFare;
      totalFare = fare + tFare;
    });
  }

  void clearAll() {
    distCtrl.clear();
    timeCtrl.clear();
    setState(() {
      totalFare = 0;
      distFareOnly = 0;
      timeFareOnly = 0;
    });
  }

  // --- ส่วน UI (ปรับปรุงใหม่) ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // สีพื้นหลังจางๆ
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. ส่วนหัว (Header) พร้อมรูปภาพ
            Stack(
              clipBehavior: Clip.none, // ยอมให้ Container ด้านล่างเกยขึ้นมาได้
              children: [
                // พื้นหลังสีเหลืองโค้งมน
                Container(
                  height: 200,
                  width: double.infinity,
                ),
                // รูปภาพแท็กซี่ (Assets)
                Positioned(
                  top: 20,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Image.asset(
                      'assets/images/taxi.png', // *** ตรวจสอบ Path ให้ถูกต้อง ***
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // 2. ส่วนเนื้อหา (Content)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  const Text('คำนวณค่าแท็กซี่',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange)),
                  const SizedBox(height: 25),

                  // ช่องกรอกระยะทาง
                  _buildInputLabel('ระยะทาง (กิโลเมตร)'),
                  TextField(
                      controller: distCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(),
                          hintText: '0.0')),

                  const SizedBox(height: 15),

                  // ช่องกรอกเวลารถติด
                  _buildInputLabel('เวลารถติด (นาที)'),
                  TextField(
                      controller: timeCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(),
                          hintText: '0')),

                  const SizedBox(height: 25),

                  // ส่วนของปุ่ม
                  Row(
                    children: [
                      // ปุ่มคำนวณราคา
                      Expanded(
                        child: ElevatedButton(
                          onPressed: calculateTaxiFare,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            foregroundColor: Colors.white,
                            fixedSize: const Size.fromHeight(50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  8), // มุมเหลี่ยมตามที่สั่ง
                            ),
                          ),
                          child: const Text('คำนวณราคา'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // ปุ่มล้างข้อมูล
                      SizedBox(
                        width: 100, // เล็กกว่า
                        child: ElevatedButton(
                          onPressed: clearAll,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.red,
                            fixedSize: const Size.fromHeight(50),
                            side: const BorderSide(color: Colors.red),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  8), // มุมเหลี่ยมเหมือนกัน
                            ),
                          ),
                          child: const Text('ล้างค่า',
                              style: TextStyle(fontSize: 13)),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 35),

                  // 3. ส่วนสรุปผล (Result Card) สีดำ
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: const Color(0xFF2C2F33), // เทาเข้ม
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                        const Text('ค่าโดยสารโดยประมาณ',
                            style: TextStyle(color: Colors.white70)),
                        Text('${totalFare.toStringAsFixed(2)} บาท',
                            style: const TextStyle(
                                color: Colors.amber,
                                fontSize: 35,
                                fontWeight: FontWeight.bold)),
                        const Divider(color: Colors.white24),
                        _buildResultRow('ค่าโดยสารตามระยะทาง:',
                            '${distFareOnly.toStringAsFixed(2)} ฿'),
                        _buildResultRow('เวลารถติด (นาที):',
                            '${timeFareOnly.toStringAsFixed(2)} ฿'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),
                  const Text('ID: 6XXXXXXXXX\nNAME: XXXX YYYYYYYYY',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper สำหรับสร้าง Label
  Widget _buildInputLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  // Helper สำหรับสร้างแถวสรุปผล
  Widget _buildResultRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white)),
          Text(value, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
