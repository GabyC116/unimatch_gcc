import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:unimatch_gcc/ui/swipe_screen.dart';
import 'package:unimatch_gcc/screens/login_screen.dart';
import 'package:unimatch_gcc/screens/register_screen.dart';
import 'package:unimatch_gcc/screens/home_screen.dart';
import 'package:unimatch_gcc/screens/profile_screen.dart';
import 'package:unimatch_gcc/data/mock_profiles.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UNIMATCH',
      debugShowCheckedModeBanner: false,
      
      // TEMA ROJO/BLANCO/AZUL SIMPLIFICADO
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD32F2F),
          brightness: Brightness.light,
        ),
        
        // FUENTE
        fontFamily: 'Roboto',
        
        // APP BAR ROJO
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFD32F2F),
          foregroundColor: Colors.white,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        // BOTONES ROJOS
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD32F2F),
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        
        // CHIPS AZULES
        chipTheme: ChipThemeData(
          backgroundColor: Color(0xFFE3F2FD),
          selectedColor: Color(0xFF1976D2),
          labelStyle: TextStyle(fontSize: 13),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        
        // FONDO
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      
      // INICIO EN LOGIN (menú)
      home: const LoginScreen(),
      
      // RUTAS
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/swipe': (context) => SwipeScreen(profiles: mockProfiles),
      },
    );
  }
}


