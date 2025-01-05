import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/repo/db_repo.dart';
import 'package:test/view/home/home_screen.dart';
import 'package:test/view/login/login.dart';
import 'package:test/view/splash/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Splashscreen(),
    );
  }
}
