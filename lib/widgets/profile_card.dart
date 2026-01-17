import 'package:flutter/material.dart';
import '../models/academic_profile.dart';

// Widget que muestra una tarjeta de perfil académico estilo Tinder
class ProfileCard extends StatelessWidget {
  final AcademicProfile profile; // Datos del perfil
  final VoidCallback? onLike;    // Función cuando dan like
  final VoidCallback? onDislike; // Función cuando dan dislike

  const ProfileCard({
    super.key,
    required this.profile,
    this.onLike,
    this.onDislike,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0), // Espacio alrededor de la tarjeta
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), // Esquinas redondeadas
        color: Colors.white, // Fondo blanco
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), // Sombra suave
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ----- PARTE SUPERIOR: FOTO -----
          _buildPhotoSection(),
          
          // ----- PARTE MEDIA: INFORMACIÓN -----
          _buildInfoSection(),
          
          // ----- PARTE INFERIOR: BOTONES -----
          _buildActionButtons(),
        ],
      ),
    );
  }

  // Sección de la foto
  Widget _buildPhotoSection() {
    return Stack(
      children: [
        // Imagen de perfil
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: Image.network(
            profile.photoUrl,
            height: 250, // Altura fija
            width: double.infinity, // Ancho completo
            fit: BoxFit.cover, // Cubrir todo el espacio
            errorBuilder: (context, error, stackTrace) {
              // Si falla la imagen, mostrar un icono
              return Container(
                height: 250,
                color: Colors.grey[200],
                child: const Icon(
                  Icons.person,
                  size: 80,
                  color: Colors.grey,
                ),
              );
            },
          ),
        ),
        // Gradiente para que el texto sea legible
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Sección de información
  Widget _buildInfoSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nombre y edad
          Row(
            children: [
              Text(
                profile.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${profile.age} años',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // Carrera y universidad
          Text(
            '${profile.career}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.blue, // Color azul para destacar
            ),
          ),
          
          Text(
            profile.university,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          
          const SizedBox(height: 12),
          
          // GPA (Promedio académico)
          Row(
            children: [
              const Icon(
                Icons.star,
                color: Colors.amber,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'GPA: ${profile.gpa}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // Materias principales (máximo 3)
          if (profile.subjects.isNotEmpty) ...[
            Text(
              'Materias:',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 4),
            Wrap(
              spacing: 8,
              children: profile.subjects
                  .take(3) // Solo mostrar 3 materias
                  .map((subject) => Chip(
                        label: Text(subject),
                        backgroundColor: Colors.blue[50],
                      ))
                  .toList(),
            ),
          ],
          
          const SizedBox(height: 12),
          
          // Biografía
          Text(
            '"${profile.bio}"',
            style: const TextStyle(
              fontSize: 15,
              fontStyle: FontStyle.italic,
              color: Colors.black54,
            ),
            maxLines: 2, // Máximo 2 líneas
            overflow: TextOverflow.ellipsis, // Puntos suspensivos si es largo
          ),
        ],
      ),
    );
  }

  // Botones de acción (Like/Dislike)
  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Espacio uniforme
        children: [
          // BOTÓN DISLIKE
          ElevatedButton.icon(
            onPressed: onDislike,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[50], // Fondo rojo claro
              foregroundColor: Colors.red, // Texto/icono rojo
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
            ),
            icon: const Icon(Icons.close),
            label: const Text('No'),
          ),
          
          // BOTÓN LIKE
          ElevatedButton.icon(
            onPressed: onLike,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[50], // Fondo verde claro
              foregroundColor: Colors.green, // Texto/icono verde
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
            ),
            icon: const Icon(Icons.favorite),
            label: const Text('Sí'),
          ),
        ],
      ),
    );
  }
}