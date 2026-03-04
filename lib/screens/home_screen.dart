import "package:flutter/material.dart";
import "package:unimatch_gcc/screens/profile_screen.dart";
import "package:unimatch_gcc/ui/swipe_screen.dart";
import "package:unimatch_gcc/data/mock_profiles.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    SwipeScreen(profiles: mockProfiles),
    const Center(
      child: Text("Matches - Próximamente", style: TextStyle(fontSize: 20)),
    ),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("UNIMATCH"),
        backgroundColor: const Color(0xFFD32F2F),
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              // Volver a la primera pestaña
              setState(() {
                _selectedIndex = 0;
              });
            },
            tooltip: 'Inicio',
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: "Descubrir",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Matches"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
      ),
    );
  }
}
