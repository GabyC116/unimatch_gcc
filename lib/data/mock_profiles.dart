import '../models/academic_profile.dart';

class MockProfiles {
  static List<AcademicProfile> getProfiles() {
    return [
      AcademicProfile(
        id: '1',
        name: 'Ana Martínez',
        photoUrl: 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=400',
        career: 'Ingeniería de Sistemas',
        university: 'UMSA',
        subjects: ['Algoritmos', 'Bases de Datos'],
        bio: 'Apasionada por la tecnología',
        gpa: 4.2,
        interests: ['Programación', 'Robótica'],
        age: 22,
        location: 'La Paz',
        distanceKm: 2.5,
      ),
      AcademicProfile(
        id: '2',
        name: 'Carlos Rodríguez',
        photoUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400',
        career: 'Medicina',
        university: 'USFX',
        subjects: ['Anatomía', 'Fisiología'],
        bio: 'Futuro cirujano cardiovascular',
        gpa: 4.5,
        interests: ['Medicina', 'Deportes'],
        age: 24,
        location: 'Sucre',
        distanceKm: 1.8,
      ),
    ];
  }
}