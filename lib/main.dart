import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:new_shop/models/cart.dart';
import 'package:new_shop/pages/auth_page.dart';
import 'package:provider/provider.dart';
import 'package:new_shop/pages/intro_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Hive инициализация и открытие бокса
  await Hive.initFlutter();
  // ...

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Cart(),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const IntroPage(),
        routes: {
          '/admin': (context) => const AuthPage(),
        },
      ),
    );
  }
}
