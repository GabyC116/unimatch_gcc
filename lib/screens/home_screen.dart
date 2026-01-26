import "package:flutter/material.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("UNIMATCH"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people, size: 100, color: Colors.blue),
            const SizedBox(height: 20),
            const Text(
              "Conecta con compañeros",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text("Encuentra tu match perfecto"),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Navegar a login
                Navigator.pushNamed(context, "/login");
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                child: Text("COMENZAR", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
