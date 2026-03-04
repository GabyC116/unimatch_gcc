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
          'No hay perfiles disponibles',
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
        backgroundColor: Colors.red.shade700,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(
              '${_currentIndex + 1}/${widget.profiles.length}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.shade200,
            color: Colors.red,
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
                  _previousProfile();
                } else if (_dragPosition < -100) {
                  _nextProfile();
                }
                setState(() {
                  _dragPosition = 0.0;
                });
              },
              child: Transform.translate(
                offset: Offset(_dragPosition, 0),
                child: _buildProfileCard(profile),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  icon: Icons.close,
                  color: Colors.red,
                  onTap: _nextProfile,
                ),
                _buildActionButton(
                  icon: Icons.favorite,
                  color: Colors.green,
                  onTap: _nextProfile,
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: Container(
                height: 280,
                width: double.infinity,
                color: Colors.grey.shade200,
                child: profile.photoUrl != null && profile.photoUrl!.isNotEmpty
                    ? Image.network(profile.photoUrl!, fit: BoxFit.cover)
                    : const Icon(Icons.person, size: 100, color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          profile.name,
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${profile.age} años',
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${profile.career}',
                    style: TextStyle(fontSize: 18, color: Colors.red.shade700, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    profile.university,
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 15),
                  const Text('📚 Materias:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: profile.subjects.map((subject) => Chip(
                      label: Text(subject),
                      backgroundColor: Colors.red.shade50,
                    )).toList(),
                  ),
                  const SizedBox(height: 20),
                  const Text('⭐ Destacado en:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: profile.interests.map((interest) => Chip(
                      label: Text(interest),
                      backgroundColor: Colors.green.shade50,
                    )).toList(),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.purple.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(profile.bio),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({required IconData icon, required Color color, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}


