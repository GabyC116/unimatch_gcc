import 'package:flutter/material.dart';

// Pantalla principal de la app
class SwipeScreen extends StatelessWidget {
  const SwipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior
      appBar: AppBar(
        title: const Text('UNIMATCH'),
        backgroundColor: Colors.blue[700],
      ),
      
      // Cuerpo principal
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icono principal
            Icon(
              Icons.people_alt,
              size: 100,
              color: Colors.blue[700],
            ),
            
            const SizedBox(height: 30),
            
            // Título
            const Text(
              'Conecta Académicamente',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 15),
            
            // Descripción
            const Text(
              'Encuentra compañeros de estudio, proyectos\n'
              'y personas con tus mismos intereses académicos.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            
            const SizedBox(height: 40),
            
            // Botón para comenzar
            ElevatedButton(
              onPressed: () {
                // Aquí iría la navegación a las tarjetas
                // Por ahora solo muestra un mensaje
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('¡Próximamente: perfiles académicos!'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700],
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
              ),
              child: const Text(
                'COMENZAR',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}