UNIMATCH - App de Conexión Académica

Hola, soy Gabriela. Esta es mi primera app completa desarrollada con Flutter. La creé para resolver un problema personal: encontrar compañeros de estudio con intereses académicos similares en mi universidad.

¿Qué es UNIMATCH?
Es una aplicación donde los estudiantes pueden crear perfiles académicos, ver otros perfiles en formato de tarjetas deslizables (como Tinder), y conectar con personas que estudian carreras similares o tienen intereses académicos en común.

Lo que logré construir
Desarrollé una app completa con 5 pantallas principales:
- Pantalla inicial con botón "Comenzar"
- Login y registro con Firebase Auth
- Pantalla principal con 3 pestañas: Descubrir, Matches y Perfil
- Tarjetas deslizables con información académica completa
- Perfiles de ejemplo con datos realistas

Características técnicas que implementé**
- Autenticación: Sistema de login/registro con Firebase
- Diseño responsivo: Funciona en web y se adapta a diferentes tamaños
- Navegación fluida: Entre todas las pantallas usando rutas nombradas
- Tema unificado: Paleta de colores rojo/blanco/azul en toda la app
- Tarjetas interactivas: Se pueden deslizar horizontalmente y scrollear verticalmente
- Gestión de estado: Para controlar qué perfil se está mostrando

El diseño que elegí
Opté por una combinación de rojo, blanco y azul:
- Rojo para acciones importantes y la barra superior
- Blanco para fondos y tarjetas
- Azul para detalles y elementos secundarios
Cada tarjeta muestra foto, nombre, edad, carrera, universidad, materias actuales, áreas de destaque y una curiosidad personal.

Lo más difícil que resolví
Configurar Firebase fue complicado al principio, especialmente generar los archivos de configuración correctos. También me costó hacer que las tarjetas se deslicen suavemente y muestren toda la información de manera organizada. Aprendí a separar el código en carpetas lógicas y a manejar los errores de compilación uno por uno.

Tecnologías que usé
- Flutter para el desarrollo frontend
- Firebase para autenticación y base de datos
- Git/GitHub para control de versiones
- Material Design para los componentes UI

Estado actual del proyecto
La app está completamente funcional con datos de ejemplo. Ya está subida a GitHub y tengo un release etiquetado como v1.0. Funciona en navegadores web y estoy orgullosa de haber llegado hasta aquí partiendo desde cero.

Próximos pasos
Continuare agregando chat entre matches, permitir subir fotos reales, implementar búsqueda por filtros y conectar de manera satisfactoria la base de datos con el frontend.
