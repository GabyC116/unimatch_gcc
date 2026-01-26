import "package:flutter/material.dart";

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de fotos simuladas (como en Tinder)
    final List<String> profilePhotos = [
      "Foto principal",
      "Foto 2", 
      "Foto 3"
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("MI PERFIL"),
        backgroundColor: Colors.blue[800],
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              print("Editar perfil");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // CARRUSEL DE FOTOS (como Tinder)
            SizedBox(
              height: 300,
              child: PageView.builder(
                itemCount: profilePhotos.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue[100],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.photo,
                          size: 100,
                          color: Colors.blue[700],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          profilePhotos[index],
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                        if (index == 0)
                          const Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Chip(
                              label: Text("FOTO PRINCIPAL"),
                              backgroundColor: Colors.amber,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            
            // Indicador de fotos (puntos como Tinder)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                profilePhotos.length,
                (index) => Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index == 0 ? Colors.blue : Colors.grey[300],
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Botón para cambiar/más fotos
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton.icon(
                    onPressed: () {
                      print("Agregar más fotos");
                    },
                    icon: const Icon(Icons.add_a_photo),
                    label: const Text("Agregar fotos"),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      print("Editar fotos");
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text("Editar"),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Resto de la información del perfil (tu código actual)
            // ... [tu código actual de perfil] ...
            
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    "Gabriela Castillo",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Ingeniería de Sistemas - 8° Semestre",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Universidad Nacional",
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 20),
                  
                  // Estadísticas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem("24", "Matches"),
                      _buildStatItem("12", "Chats"),
                      _buildStatItem("3", "Fotos"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
