import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_card/flutter_swipe_action_card.dart'; // Para swipe
import '../models/academic_profile.dart';

class SwipeScreen extends StatefulWidget {
  final List<AcademicProfile> profiles;
  
  const SwipeScreen({Key? key, required this.profiles}) : super(key: key);

  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  int _currentIndex = 0;
  bool _showFullInfo = false;
  final GlobalKey<SwipeActionCardState> _cardKey = GlobalKey<SwipeActionCardState>();

  // Calcula semestre
  int _calculateSemester(int age) {
    const universityStartAge = 18;
    if (age <= universityStartAge) return 1;
    final yearsInUniversity = age - universityStartAge;
    final semester = yearsInUniversity * 2;
    return semester > 10 ? 10 : semester;
  }

  void _onSwipeLeft() {
    // Swipe izquierda = RECHAZAR
    _cardKey.currentState?.swipeLeft();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted && _currentIndex < widget.profiles.length - 1) {
        setState(() {
          _currentIndex++;
          _showFullInfo = false;
        });
      }
    });
  }

  void _onSwipeRight() {
    // Swipe derecha = ACEPTAR
    _cardKey.currentState?.swipeRight();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted && _currentIndex < widget.profiles.length - 1) {
        setState(() {
          _currentIndex++;
          _showFullInfo = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final profile = widget.profiles[_currentIndex];
    final semester = _calculateSemester(profile.age);
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ENCABEZADO
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'UNIMATCH',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD32F2F),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD32F2F).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${_currentIndex + 1}/${widget.profiles.length}',
                      style: const TextStyle(
                        color: Color(0xFFD32F2F),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // TARJETA CON SWIPE
            Expanded(
              child: SwipeActionCard(
                key: _cardKey,
                swipeUp: true,
                swipeDown: true,
                swipeLeft: true,
                swipeRight: true,
                onSwipeLeft: _onSwipeLeft,
                onSwipeRight: _onSwipeRight,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // IMAGEN DE FONDO
                        Image.network(
                          profile.photoUrl,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              color: Colors.grey[200],
                              child: const Center(
                                child: CircularProgressIndicator(color: Color(0xFFD32F2F)),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: const Color(0xFF1976D2),
                              child: const Center(
                                child: Icon(
                                  Icons.person,
                                  size: 100,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                        ),
                        
                        // GRADIENTE OSCURO
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.center,
                              colors: [
                                Colors.black.withOpacity(0.9),
                                Colors.black.withOpacity(0.5),
                                Colors.transparent,
                              ],
                              stops: const [0.0, 0.5, 0.8],
                            ),
                          ),
                        ),
                        
                        // INFORMACIÓN COMPLETA
                        Positioned(
                          bottom: 20,
                          left: 20,
                          right: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // NOMBRE Y EDAD
                              Text(
                                '${profile.name}, ${profile.age}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black54,
                                      blurRadius: 10,
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              
                              // CARRERA
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD32F2F),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  profile.career.toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              
                              // SEMESTRE
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.school,
                                      color: Color(0xFFD32F2F),
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    '$semesterº SEMESTRE',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black54,
                                          blurRadius: 8,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              
                              // BOTÓN PARA MOSTRAR/OCULTAR INFORMACIÓN COMPLETA
                              const SizedBox(height: 20),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _showFullInfo = !_showFullInfo;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 8,
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        _showFullInfo ? Icons.expand_less : Icons.expand_more,
                                        color: const Color(0xFFD32F2F),
                                        size: 24,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        _showFullInfo ? 'Menos información' : 'Más información',
                                        style: const TextStyle(
                                          color: Color(0xFFD32F2F),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              
                              // INFORMACIÓN ACADÉMICA COMPLETA (se muestra al tocar)
                              if (_showFullInfo) ...[
                                const SizedBox(height: 20),
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // UNIVERSIDAD
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              profile.university,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 15),
                                      
                                      // MATERIAS
                                      const Text(
                                        '📚 Materias este semestre:',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      ...profile.subjects.take(4).map((subject) => Padding(
                                        padding: const EdgeInsets.only(bottom: 6),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.book, color: Colors.white70, size: 16),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                subject,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                      const SizedBox(height: 15),
                                      
                                      // INTERESES
                                      if (profile.interests.isNotEmpty) ...[
                                        const Text(
                                          '⭐ Intereses académicos:',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Wrap(
                                          spacing: 8,
                                          runSpacing: 6,
                                          children: profile.interests.take(5).map((interest) => Chip(
                                            label: Text(
                                              interest,
                                              style: const TextStyle(fontSize: 14),
                                            ),
                                            backgroundColor: const Color(0xFF1976D2),
                                            labelStyle: const TextStyle(color: Colors.white),
                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                          )).toList(),
                                        ),
                                        const SizedBox(height: 15),
                                      ],
                                      
                                      // BIO
                                      if (profile.bio.isNotEmpty) ...[
                                        const Text(
                                          '📝 Sobre mí:',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          profile.bio,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ],
                                      
                                      // GPA (opcional)
                                      if (profile.gpa > 0) ...[
                                        const SizedBox(height: 15),
                                        Row(
                                          children: [
                                            const Icon(Icons.star, color: Colors.yellow, size: 20),
                                            const SizedBox(width: 10),
                                            Text(
                                              'GPA: ${profile.gpa.toStringAsFixed(1)}',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        
                        // INDICADORES DE SWIPE
                        Positioned(
                          top: 20,
                          right: 20,
                          child: AnimatedOpacity(
                            opacity: _showFullInfo ? 0.0 : 1.0,
                            duration: const Duration(milliseconds: 300),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.swipe_left, color: Colors.white, size: 18),
                                  SizedBox(width: 6),
                                  Text(
                                    'Desliza',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            
            // BOTONES DE ACCIÓN FIJOS
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // BOTÓN X (RECHAZAR)
                  Container(
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.close, size: 36),
                      color: const Color(0xFFD32F2F),
                      onPressed: _onSwipeLeft,
                    ),
                  ),
                  const SizedBox(width: 60),
                  // BOTÓN CORAZÓN (ACEPTAR)
                  Container(
                    width: 85,
                    height: 85,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.favorite, size: 40),
                      color: const Color(0xFFD32F2F),
                      onPressed: _onSwipeRight,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      
      // BARRA DE NAVEGACIÓN INFERIOR
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Descubrir seleccionado
        selectedItemColor: const Color(0xFFD32F2F),
        unselectedItemColor: Colors.grey[600],
        backgroundColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Descubrir',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Matches',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
