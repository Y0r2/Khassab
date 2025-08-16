import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'splash_screen.dart';

// التطبيق المستقر النهائي
void main() {
  runApp(const KhassabApp());
}

class KhassabApp extends StatelessWidget {
  const KhassabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'خصب عسير',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Arial',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 16),
          bodyMedium: TextStyle(fontSize: 14),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
