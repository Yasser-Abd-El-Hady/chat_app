import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/views/screens/auth_screens/chat_screen.dart';
import 'package:chat_app/views/screens/auth_screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthScreen(),
      routes: {
        AuthScreen.pageRoute: (context) => const AuthScreen(),
        ChatScreen.pageRoute: (context) => ChatScreen(),
      },
    );
  }
}
