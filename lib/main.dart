import 'package:flutter/material.dart';
import 'package:learnapp/services/database.dart';
import 'package:learnapp/pages/start/splash_screen.dart';
import 'package:learnapp/pages/start/login.dart';
import 'package:learnapp/pages/start/register.dart';
import 'package:learnapp/pages/features/chatbot.dart';
import 'package:learnapp/pages/features/home.dart';
import 'package:learnapp/pages/features/profile.dart';
import 'package:learnapp/pages/features/quiz_detail.dart';
import 'package:learnapp/pages/features/quiz_list.dart';
import 'package:learnapp/pages/features/read_book.dart';
import 'package:learnapp/pages/features/scan_book.dart';
import 'package:learnapp/pages/features/summary_detail.dart';
import 'package:learnapp/pages/features/summary_list.dart';
import 'package:learnapp/pages/features/upload_file.dart';

void main() {
  final dbService = DatabaseService(
    host: const String.fromEnvironment('DB_HOST'),
    port: int.parse(
      const String.fromEnvironment('DB_PORT', defaultValue: '5432'),
    ),
    databaseName: const String.fromEnvironment('DB_NAME'),
    username: const String.fromEnvironment('DB_USERNAME'),
    password: const String.fromEnvironment('DB_PASSWORD'),
  );

  runApp(MyApp(dbService: dbService));
}

class MyApp extends StatelessWidget {
  final DatabaseService dbService;

  const MyApp({required this.dbService, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LearnApp',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
        '/chatbot': (context) => const Chatbot(),
        '/home': (context) => const Home(),
        '/profile': (context) => const Profile(),
        '/quiz_detail': (context) => const QuizDetail(),
        '/quiz_list': (context) => const QuizList(),
        '/read_book': (context) => const ReadBook(),
        '/scan_book': (context) => const ScanBook(),
        '/summary_detail': (context) => const SummaryDetail(),
        '/summary_list': (context) => const SummaryList(),
        '/upload_file': (context) => const UploadFile(),
      },
    );
  }
}
