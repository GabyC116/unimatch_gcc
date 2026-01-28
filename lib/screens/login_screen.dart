import "package:flutter/material.dart";

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("INICIAR SESIÓN"),
        backgroundColor: Colors.blue[800],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icono
            Icon(Icons.lock_person, size: 80, color: const Color(0xFFD32F2F)),
            const SizedBox(height: 20),
            
            // Título
            const Text(
              "Bienvenido de nuevo",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            
            const Text(
              "Ingresa a tu cuenta Unimatch",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 40),
            
            // Campo Email
            TextField(
              decoration: InputDecoration(
                labelText: "Correo electrónico",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 20),
            
            // Campo Contraseña
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Contraseña",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 30),
            
            // Botón Login
            ElevatedButton(
              onPressed: () {
                // Navegar a home
                Navigator.pushReplacementNamed(context, "/home");
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("INICIAR SESIÓN"),
            ),
            const SizedBox(height: 20),
            
            // Enlace a registro - ESTE ES EL BOTÓN IMPORTANTE
            TextButton(
              onPressed: () {
                // NAVEGAR A PANTALLA DE REGISTRO
                Navigator.pushNamed(context, "/register");
              },
              child: const Text(
                "¿No tienes cuenta? Regístrate",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

