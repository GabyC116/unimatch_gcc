import 'package:flutter/material.dart';
import '../models/academic_profile.dart';

class SwipeScreen extends StatefulWidget {
  final List<AcademicProfile> profiles;
  
  const SwipeScreen({super.key, required this.profiles});

  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  int _currentIndex = 0;
  double _dragPosition = 0.0;

  void _nextProfile() {
    if (_currentIndex < widget.profiles.length - 1) {
      setState(() {
        _currentIndex++;
        _dragPosition = 0.0;
      });
    }
  }

  void _previousProfile() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _dragPosition = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.profiles.isEmpty) {
      return const Center(
        child: Text(
          'No hay perfiles disponibles\nVuelve más tarde',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }

    final profile = widget.profiles[_currentIndex];
    final progress = (_currentIndex + 1) / widget.profiles.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Descubrir'),
        backgroundColor: const Color(0xFFD32F2F),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(
              '${_currentIndex + 1}/${widget.profiles.length}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Barra de progreso
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[200],
            color: const Color(0xFFD32F2F),
            minHeight: 3,
          ),
          
          Expanded(
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                setState(() {
                  _dragPosition += details.delta.dx;
                });
              },
              onHorizontalDragEnd: (details) {
                if (_dragPosition > 100) {
                  _previousProfile(); // Deslizar derecha
                } else if (_dragPosition < -100) {
                  _nextProfile(); // Deslizar izquierda
                }
                setState(() {
                  _dragPosition = 0.0;
                });
              },
              child: Transform.translate(
                offset: Offset(_dragPosition, 0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.all(20),
                  child: _buildProfileCard(profile),
                ),
              ),
            ),
          ),
          
          // Botones de acción
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Botón rechazar
                _buildActionButton(
                  icon: Icons.close,
                  color: const Color(0xFFD32F2F),
                  onTap: _nextProfile,
                  size: 60,
                ),
                
                // Botón like
                _buildActionButton(
                  icon: Icons.favorite,
                  color: const Color(0xFF1976D2),
                  onTap: _nextProfile,
                  size: 70,
                ),
                
                // Botón ver detalles
                _buildActionButton(
                  icon: Icons.info,
                  color: const Color(0xFFD32F2F),
                  onTap: () {
                    _showProfileDetails(context, profile);
                  },
                  size: 60,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

    Widget _buildProfileCard(AcademicProfile profile) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          // Foto de perfil
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Container(
              height: 280,
              width: double.infinity,
              color: const Color(0xFFFFEBEE),
              child: profile.photoUrl != null && profile.photoUrl!.isNotEmpty
                  ? Image.network(
                      profile.photoUrl!,
                      fit: BoxFit.cover,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          size: 100,
                          color: const Color(0xFFEF9A9A),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          profile.name,
                          style: TextStyle(
                            fontSize: 24,
                            color: const Color(0xFFD32F2F),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          
          // Información DEBAJO de la imagen
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nombre y edad
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      profile.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD32F2F),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${profile.age} años',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 8),
                
                // Carrera y universidad
                Text(
                  '🎓 ${profile.career}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: const Color(0xFFD32F2F),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                
                const SizedBox(height: 5),
                
                Text(
                  '🏛️ ${profile.university}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade700,
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Divider
                Divider(color: Colors.grey.shade300),
                
                const SizedBox(height: 15),
                
                // Materias actuales
                const Text(
                  '📚 Materias este semestre:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: profile.subjects.map((subject) => Chip(
                    label: Text(subject),
                    backgroundColor: const Color(0xFFFFEBEE),
                    labelStyle: const TextStyle(fontSize: 13),
                  )).toList(),
                ),
                
                const SizedBox(height: 20),
                
                // Áreas destacadas
                const Text(
                  '⭐ Destacado en:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: profile.interests.map((interest) => Chip(
                    label: Text(interest),
                    backgroundColor: const Color(0xFFE3F2FD),
                    labelStyle: const TextStyle(fontSize: 13),
                  )).toList(),
                ),
                
                const SizedBox(height: 20),
                
                // Actividades/Curiosidades (en un recuadro especial)
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F2FD),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF90CAF9)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.emoji_objects, color: const Color(0xFF1976D2), size: 24),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Sobre mí:',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF1976D2),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              profile.bio,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    double size = 60,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: size * 0.5,
        ),
      ),
    );
  }

  void _showProfileDetails(BuildContext context, AcademicProfile profile) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: ListView(
                controller: scrollController,
                children: [
                  // Header con foto
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
                      image: profile.photoUrl != null && profile.photoUrl!.isNotEmpty
                          ? DecorationImage(
                              image: NetworkImage(profile.photoUrl!),
                              fit: BoxFit.cover,
                            )
                          : null,
                      color: const Color(0xFFFFEBEE),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 20,
                          right: 20,
                          child: IconButton(
                            icon: const Icon(Icons.close, color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nombre y edad
                        Row(
                          children: [
                            Text(
                              profile.name,
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFFD32F2F),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                '${profile.age} años',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 10),
                        
                        // Carrera y universidad
                        Text(
                          '${profile.career} • ${profile.university}',
                          style: TextStyle(
                            fontSize: 18,
                            color: const Color(0xFFD32F2F),
                          ),
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Bio completa
                        const Text(
                          'Sobre mí:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          profile.bio,
                          style: TextStyle(fontSize: 16),
                        ),
                        
                        const SizedBox(height: 30),
                        
                        // Materias actuales
                        const Text(
                          '📚 Materias actuales:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: profile.subjects.map((subject) => Chip(
                            label: Text(subject),
                            backgroundColor: const Color(0xFFFFCDD2),
                            labelStyle: TextStyle(fontSize: 14),
                          )).toList(),
                        ),
                        
                        const SizedBox(height: 30),
                        
                        // Áreas destacadas
                        const Text(
                          '⭐ Áreas destacadas:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: profile.interests.map((interest) => Chip(
                            label: Text(interest),
                            backgroundColor: const Color(0xFFBBDEFB),
                            labelStyle: TextStyle(fontSize: 14),
                          )).toList(),
                        ),
                        
                        const SizedBox(height: 30),
                        
                        // Estadísticas
                        const Text(
                          '📊 Estadísticas:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStatItem(Icons.star, 'GPA', '${profile.gpa}'),
                            _buildStatItem(Icons.location_on, 'Distancia', '${profile.distanceKm} km'),
                            _buildStatItem(Icons.school, 'Materias', '${profile.subjects.length}'),
                            _buildStatItem(Icons.interests, 'Intereses', '${profile.interests.length}'),
                          ],
                        ),
                        
                        const SizedBox(height: 40),
                        
                        // Botones de acción
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                icon: const Icon(Icons.close),
                                label: const Text('Rechazar'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: const Color(0xFFD32F2F),
                                  side: const BorderSide(color: Colors.red),
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  _nextProfile();
                                },
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: ElevatedButton.icon(
                                icon: const Icon(Icons.favorite),
                                label: const Text('Me interesa'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1976D2),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  _nextProfile();
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildStatItem(IconData icon, String title, String value) {
    return Column(
      children: [
        Icon(icon, size: 30, color: const Color(0xFFD32F2F)),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}






