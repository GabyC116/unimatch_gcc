import "package:flutter/material.dart";

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  String? _selectedUniversity;
  String? _selectedCareer;
  final List<String> _selectedInterests = [];
  final List<String> _profilePhotos = [];
  
  final List<String> _universities = [
    "Universidad Nacional",
    "Universidad de los Andes", 
    "Universidad Javeriana",
    "Universidad del Rosario",
    "Universidad Externado",
    "Otra universidad"
  ];
  
  final List<String> _careers = [
    "Ingeniería de Sistemas",
    "Ingeniería Civil",
    "Medicina",
    "Derecho",
    "Administración de Empresas",
    "Psicología",
    "Arquitectura",
    "Otra carrera"
  ];
  
  final List<String> _allInterests = [
    "Matemáticas", "Física", "Química", "Programación",
    "Bases de Datos", "Redes", "Inteligencia Artificial",
    "Inglés", "Francés", "Diseño Gráfico", "Marketing",
    "Contabilidad", "Estadística", "Investigación"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CREAR CUENTA"),
        backgroundColor: Colors.blue[800],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            
            const Text(
              "Crea tu perfil Unimatch",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text(
              "Agrega fotos y detalles para encontrar tu match perfecto",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            
            const SizedBox(height: 30),
            
            // SECCIÓN DE FOTOS
            _buildPhotosSection(),
            
            const SizedBox(height: 30),
            
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: () {
                  _registerWithGoogle();
                },
                icon: const Icon(Icons.g_mobiledata, size: 24),
                label: const Text(
                  "Continuar con Google",
                  style: TextStyle(fontSize: 16),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey[300]!),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            Row(
              children: [
                Expanded(child: Divider(color: Colors.grey[300])),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text("O regístrate con", style: TextStyle(color: Colors.grey[600])),
                ),
                Expanded(child: Divider(color: Colors.grey[300])),
              ],
            ),
            
            const SizedBox(height: 20),
            
            _buildTextField("Nombre completo", Icons.person, _nameController),
            const SizedBox(height: 15),
            _buildTextField("Correo electrónico", Icons.email, _emailController, TextInputType.emailAddress),
            const SizedBox(height: 15),
            _buildTextField("Contraseña", Icons.lock, _passwordController, null, true),
            const SizedBox(height: 15),
            _buildTextField("Confirmar contraseña", Icons.lock, _confirmPasswordController, null, true),
            
            const SizedBox(height: 25),
            
            const Text(
              "Universidad",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedUniversity,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                prefixIcon: const Icon(Icons.school),
              ),
              items: _universities.map((university) {
                return DropdownMenuItem(
                  value: university,
                  child: Text(university),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedUniversity = value;
                });
              },
              hint: const Text("Selecciona tu universidad"),
            ),
            
            const SizedBox(height: 20),
            
            const Text(
              "Carrera",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedCareer,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                prefixIcon: const Icon(Icons.work),
              ),
              items: _careers.map((career) {
                return DropdownMenuItem(
                  value: career,
                  child: Text(career),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCareer = value;
                });
              },
              hint: const Text("Selecciona tu carrera"),
            ),
            
            const SizedBox(height: 25),
            
            const Text(
              "Intereses de estudio (selecciona varios)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _allInterests.map((interest) {
                final isSelected = _selectedInterests.contains(interest);
                return FilterChip(
                  label: Text(interest),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedInterests.add(interest);
                      } else {
                        _selectedInterests.remove(interest);
                      }
                    });
                  },
                  backgroundColor: isSelected ? Colors.blue[100] : Colors.grey[100],
                  selectedColor: Colors.blue[200],
                  checkmarkColor: Colors.blue,
                );
              }).toList(),
            ),
            
            const SizedBox(height: 35),
            
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  _registerUser();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "CREAR CUENTA",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("¿Ya tienes cuenta?"),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/login");
                  },
                  child: const Text(
                    "Inicia sesión",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
  
  // SECCIÓN DE FOTOS (3 máximo) - VERSIÓN CORREGIDA
  Widget _buildPhotosSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "📸 Fotos de perfil",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        const Text(
          "Agrega hasta 3 fotos (la primera será tu foto principal)",
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 15),
        
        // Contenedor de fotos
        Container(
          height: 120,
          child: Row(
            children: [
              // Fotos existentes
              for (int i = 0; i < _profilePhotos.length; i++)
                _buildPhotoContainer(i),
              
              // Botón para agregar (si hay menos de 3)
              if (_profilePhotos.length < 3)
                _buildAddPhotoButton(),
            ],
          ),
        ),
        
        const SizedBox(height: 10),
        Text(
          "${_profilePhotos.length}/3 fotos agregadas",
          style: TextStyle(
            fontSize: 14,
            color: _profilePhotos.length == 3 ? Colors.green : Colors.grey,
            fontWeight: _profilePhotos.length == 3 ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
  
  Widget _buildPhotoContainer(int index) {
    return Container(
      width: 100,
      height: 100,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.blue[50],
        border: Border.all(color: Colors.blue, width: 2),
      ),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.photo,
                  size: 40,
                  color: Colors.blue[700],
                ),
                const SizedBox(height: 5),
                Text(
                  index == 0 ? "Principal" : "Foto ${index + 1}",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // Botón para eliminar
          Positioned(
            top: 5,
            right: 5,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _profilePhotos.removeAt(index);
                });
              },
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, size: 12, color: Colors.white),
              ),
            ),
          ),
          
          // Indicador de foto principal
          if (index == 0)
            Positioned(
              top: 5,
              left: 5,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.star, size: 12, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
  
  Widget _buildAddPhotoButton() {
    return GestureDetector(
      onTap: () {
        _showAddPhotoDialog();
      },
      child: Container(
        width: 100,
        height: 100,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey[100],
          border: Border.all(color: Colors.grey[400]!, width: 1),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle, size: 40, color: Colors.grey),
            SizedBox(height: 5),
            Text(
              "Agregar foto",
              style: TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
  
  void _showAddPhotoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Agregar foto"),
        content: const Text("¿Cómo quieres agregar la foto?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _addPhoto("Cámara");
            },
            child: const Text("Tomar foto"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _addPhoto("Galería");
            },
            child: const Text("Elegir de galería"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
        ],
      ),
    );
  }
  
  void _addPhoto(String source) {
    if (_profilePhotos.length >= 3) {
      _showMessage("Máximo 3 fotos alcanzado");
      return;
    }
    
    setState(() {
      _profilePhotos.add("Foto ${_profilePhotos.length + 1} ($source)");
    });
    
    _showMessage("Foto agregada desde $source (simulación)");
  }
  
  Widget _buildTextField(
    String label, 
    IconData icon, 
    TextEditingController controller,
    [TextInputType? keyboardType, 
    bool obscureText = false]
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
    );
  }
  
  void _registerWithGoogle() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Registro con Google"),
        content: const Text("Esta función simula autenticación con Google"),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Simular datos
              _nameController.text = "Usuario Google";
              _emailController.text = "usuario@gmail.com";
              _selectedUniversity = "Universidad Nacional";
              _selectedCareer = "Ingeniería de Sistemas";
              setState(() {});
              _showMessage("Datos de Google cargados");
            },
            child: const Text("Simular"),
          ),
        ],
      ),
    );
  }
  
  void _registerUser() {
    if (_nameController.text.isEmpty) {
      _showMessage("Por favor ingresa tu nombre");
      return;
    }
    
    if (_profilePhotos.isEmpty) {
      _showMessage("Agrega al menos una foto de perfil");
      return;
    }
    
    print("=== REGISTRO EXITOSO ===");
    print("Fotos: ${_profilePhotos.length}");
    print("Nombre: ${_nameController.text}");
    
    Navigator.pushReplacementNamed(context, "/home");
  }
  
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
