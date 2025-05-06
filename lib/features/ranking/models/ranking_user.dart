// Eliminar esta importación ya que no se utiliza
// import 'dart:convert';

class RankingUser {
  final String name;
  final int points;
  final int level;
  final int streak;
  final String avatarUrl;
  final String language; // Nuevo campo para el idioma

  RankingUser({
    required this.name,
    required this.points,
    required this.level,
    required this.streak,
    required this.avatarUrl,
    this.language = 'Japonés', // Valor predeterminado
  });

  // Método para convertir de JSON a objeto
  factory RankingUser.fromJson(Map<String, dynamic> json) {
    return RankingUser(
      name: json['name'] as String,
      points: json['points'] as int,
      level: json['level'] as int,
      streak: json['streak'] as int,
      avatarUrl: json['avatarUrl'] as String,
      language: json['language'] as String? ?? 'Japonés',
    );
  }

  // Método para convertir de objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'points': points,
      'level': level,
      'streak': streak,
      'avatarUrl': avatarUrl,
      'language': language,
    };
  }
}