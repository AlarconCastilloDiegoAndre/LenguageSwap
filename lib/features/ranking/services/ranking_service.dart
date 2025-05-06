import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/ranking_user.dart';

class RankingService {
  // Lista de archivos JSON para cada idioma
  static const Map<String, String> _languageFiles = {
    'Japonés': 'assets/data/ranking_data_japanese.json',
    'Inglés': 'assets/data/ranking_data_english.json',
    'Francés': 'assets/data/ranking_data_french.json',
    'Alemán': 'assets/data/ranking_data_german.json',
    'Italiano': 'assets/data/ranking_data_italian.json',
    'Todos': 'assets/data/ranking_data_all.json',
  };

  Future<List<RankingUser>> getRankingUsers({String language = 'Japonés'}) async {
    try {
      print('Intentando cargar datos para el idioma: $language');
      
      // Si se selecciona "Todos", cargar datos de todos los idiomas
      if (language == 'Todos') {
        return await _getAllLanguagesRanking();
      }
      
      // De lo contrario, cargar datos del idioma específico
      String fileName = _languageFiles[language] ?? _languageFiles['Japonés']!;
      print('Cargando archivo: $fileName');
      
      return await _loadRankingFromFile(fileName);
    } catch (e) {
      print('Error al cargar datos de ranking: $e');
      // Devolver datos de ejemplo en caso de error
      return _getDefaultUsers(language);
    }
  }

  // Método para cargar datos de un archivo específico
  Future<List<RankingUser>> _loadRankingFromFile(String fileName) async {
    try {
      final String response = await rootBundle.loadString(fileName);
      print('Archivo cargado correctamente: $fileName');
      
      final List<dynamic> data = json.decode(response);
      print('Datos decodificados. Número de usuarios: ${data.length}');
      
      return data.map((json) => RankingUser.fromJson(json)).toList();
    } catch (e) {
      print('Error al cargar archivo $fileName: $e');
      throw e; // Relanzar para manejar en el método principal
    }
  }

  // Método para cargar y combinar datos de todos los idiomas
  Future<List<RankingUser>> _getAllLanguagesRanking() async {
    List<RankingUser> allUsers = [];
    
    // Intentar cargar el archivo "Todos" primero
    try {
      final users = await _loadRankingFromFile(_languageFiles['Todos']!);
      return users;
    } catch (e) {
      print('Error al cargar archivo para "Todos", intentando combinar: $e');
    }
    
    // Si falla, intentar combinar todos los idiomas
    for (String language in _languageFiles.keys) {
      if (language == 'Todos') continue; // Saltar "Todos"
      
      try {
        final users = await _loadRankingFromFile(_languageFiles[language]!);
        allUsers.addAll(users);
        print('Agregados ${users.length} usuarios del idioma $language');
      } catch (e) {
        print('Error al cargar archivo para $language: $e');
      }
    }
    
    if (allUsers.isEmpty) {
      print('No se pudieron cargar datos para ningún idioma, usando datos por defecto');
      return _getDefaultUsers('Todos');
    }
    
    return allUsers;
  }
  
  // Datos de ejemplo para usar en caso de error
  List<RankingUser> _getDefaultUsers(String language) {
    print('Generando datos de ejemplo para: $language');
    
    if (language == 'Todos') {
      return [
        RankingUser(name: 'Usuario Ejemplo 1', points: 1000, level: 5, streak: 10, avatarUrl: '', language: 'Japonés'),
        RankingUser(name: 'Usuario Ejemplo 2', points: 900, level: 4, streak: 8, avatarUrl: '', language: 'Inglés'),
        RankingUser(name: 'Usuario Ejemplo 3', points: 800, level: 4, streak: 7, avatarUrl: '', language: 'Francés'),
      ];
    }
    
    return [
      RankingUser(name: 'Usuario Ejemplo 1', points: 1000, level: 5, streak: 10, avatarUrl: '', language: language),
      RankingUser(name: 'Usuario Ejemplo 2', points: 900, level: 4, streak: 8, avatarUrl: '', language: language),
      RankingUser(name: 'Usuario Ejemplo 3', points: 800, level: 4, streak: 7, avatarUrl: '', language: language),
    ];
  }
}