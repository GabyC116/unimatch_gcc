class AcademicProfile {
  final String id;
  final String name;
  final String photoUrl;
  final String career;
  final String university;
  final List<String> subjects;
  final String bio;
  final double gpa;
  final List<String> interests;
  final int age;
  final String location;
  final double distanceKm;
  final int semester; // ← CAMPO NUEVO

  AcademicProfile({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.career,
    required this.university,
    required this.subjects,
    required this.bio,
    required this.gpa,
    required this.interests,
    required this.age,
    required this.location,
    required this.distanceKm,
    this.semester = 1, // ← Valor por defecto
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'photoUrl': photoUrl,
      'career': career,
      'university': university,
      'subjects': subjects,
      'bio': bio,
      'gpa': gpa,
      'interests': interests,
      'age': age,
      'location': location,
      'distanceKm': distanceKm,
      'semester': semester, // ← Incluido
    };
  }

  factory AcademicProfile.fromMap(Map<String, dynamic> map) {
    return AcademicProfile(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      career: map['career'] ?? '',
      university: map['university'] ?? '',
      subjects: List<String>.from(map['subjects'] ?? []),
      bio: map['bio'] ?? '',
      gpa: map['gpa']?.toDouble() ?? 0.0,
      interests: List<String>.from(map['interests'] ?? []),
      age: map['age']?.toInt() ?? 0,
      location: map['location'] ?? '',
      distanceKm: map['distanceKm']?.toDouble() ?? 0.0,
      semester: map['semester']?.toInt() ?? 1, // ← Incluido
    );
  }
}
