import "package:flutter/material.dart";
import "screens/home_screen.dart";
import "screens/login_screen.dart";
import "screens/profile_screen.dart";
import "screens/register_screen.dart";

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Unimatch",
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => const HomeScreen(),
        "/login": (context) => const LoginScreen(),
        "/profile": (context) => const ProfileScreen(),
        "/register": (context) => const RegisterScreen(),
        "/home": (context) => const HomeScreen(),
      },
    );
  }
}
