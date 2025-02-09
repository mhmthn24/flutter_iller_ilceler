import 'package:flutter/material.dart';
import 'package:flutter_iller_ilceler/Anasayfa.dart';

void main() {
  runApp(AnaUygulama());
}

class AnaUygulama extends StatelessWidget {
  const AnaUygulama({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Anasayfa(),
      debugShowCheckedModeBanner: false,
    );
  }
}
