import 'package:flutter/material.dart';
import 'package:flutter_taxi_app/taxi/screen.dart';
import 'package:google_fonts/google_fonts.dart';


void main() {
  runApp(flutter_taxi_app(),
  );
}
class flutter_taxi_app extends StatefulWidget {
  const flutter_taxi_app({super.key});

  @override
  State<flutter_taxi_app> createState() => _flutter_taxi_appState();
}

class _flutter_taxi_appState extends State<flutter_taxi_app> {
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Screen(),
      theme: ThemeData(
        textTheme: GoogleFonts.kanitTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
    );
  }
}