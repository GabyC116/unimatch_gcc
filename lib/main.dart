import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:unimatch_gcc/screens/home_screen.dart';
import 'package:unimatch_gcc/ui/swipe_screen.dart';
import 'package:unimatch_gcc/screens/login_screen.dart';
import 'package:unimatch_gcc/screens/register_screen.dart';
import 'package:unimatch_gcc/screens/home_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UNIMATCH',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,

      // Ruta inicial
      home: const LoginScreen(),

      // Definir rutas con nombre
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
