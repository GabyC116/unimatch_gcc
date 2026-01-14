import 'package:flutter/material.dart';

void main() {
  runApp(const UnimatchApp());
}

class UnimatchApp extends StatelessWidget {
  const UnimatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UNIMATCH by GCC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Roboto', // CORREGIDO: era 'Robototo'
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UNIMATCH 🎓'),
        centerTitle: true,
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white, // Añadido: texto blanco
        elevation: 0,
      ),
      body: Container(
        color: Colors.white, // Fondo blanco seguro
        child: Center(
          child: SingleChildScrollView( // Para scroll si es necesario
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo/Icono
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.purple.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.school,
                    size: 60,
                    color: Colors.purple,
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // Título
                const Text(
                  '¡Bienvenida a UNIMATCH!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                
                const SizedBox(height: 15),
                
                // Subtítulo
                const Text(
                  'Matching Académico para la UMSS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // Botón COMENZAR (MORADO)
                SizedBox(
                  width: double.infinity, // Ancho completo
                  height: 56, // Altura fija
                  child: ElevatedButton(
                    onPressed: () {
                      print('¡Comenzando matching académico!');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple, // Fondo morado
                      foregroundColor: Colors.white, // Texto blanco
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      shadowColor: Colors.purple.withOpacity(0.3),
                    ),
                    child: const Text(
                      'COMENZAR',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Botón MI PERFIL (BORDE MORADO)
                SizedBox(
                  width: double.infinity, // Ancho completo
                  height: 56, // Altura fija
                  child: OutlinedButton(
                    onPressed: () {
                      print('Ver perfil académico');
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Colors.purple,
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      foregroundColor: Colors.purple, // Texto morado
                    ),
                    child: const Text(
                      'MI PERFIL ACADÉMICO',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // Texto pequeño
                const Text(
                  'Conecta con compañeros de estudio\ncompartiendo materias e intereses',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}