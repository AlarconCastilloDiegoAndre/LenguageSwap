import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/writing_exercise.dart';

class WritingService {
  Future<List<WritingExercise>> getWritingExercises({required String language}) async {
    try {
      // Mapear el idioma seleccionado al nombre del archivo correspondiente
      String fileName;
      switch (language) {
        case 'Japonés':
          fileName = 'assets/data/writing_exercises_japanese.json';
          break;
        case 'Inglés':
          fileName = 'assets/data/writing_exercises_english.json';
          break;
        case 'Francés':
          fileName = 'assets/data/writing_exercises_french.json';
          break;
        case 'Alemán':
          fileName = 'assets/data/writing_exercises_german.json';
          break;
        default:
          // Por defecto, usar japonés
          fileName = 'assets/data/writing_exercises_japanese.json';
      }

      // Cargar el archivo JSON
      final String response = await rootBundle.loadString(fileName);
      final List<dynamic> data = json.decode(response);
      
      // Convertir los datos JSON a objetos WritingExercise
      return data.map((json) => WritingExercise.fromJson(json)).toList();
    } catch (e) {
      print('Error al cargar ejercicios de escritura: $e');
      // En caso de error, devolver ejercicios por defecto
      return _getDefaultExercises(language);
    }
  }
  
  // Datos de ejemplo para usar en caso de error
  List<WritingExercise> _getDefaultExercises(String language) {
    print('Generando ejercicios de ejemplo para: $language');
    
    if (language == 'Japonés') {
      return [
        WritingExercise(
          id: 'jp1',
          title: '自己紹介',
          prompt: '簡単な自己紹介を書いてください。名前、年齢、趣味などを含めてください。',
          language: language,
          difficulty: 1,
          keywords: ['名前', '年齢', '趣味'],
          minWords: 30,
          maxWords: 100,
          imageUrl: 'https://images.unsplash.com/photo-1528164344705-47542687000d?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
        ),
        WritingExercise(
          id: 'jp2',
          title: '私の一日',
          prompt: 'あなたの典型的な一日について書いてください。朝起きてから夜寝るまでの活動を説明してください。',
          language: language,
          difficulty: 1,
          keywords: ['朝', '昼', '夜', '活動'],
          minWords: 50,
          maxWords: 150,
          imageUrl: 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
        ),
        WritingExercise(
          id: 'jp3',
          title: '私の好きな食べ物',
          prompt: 'あなたの好きな食べ物について書いてください。なぜそれが好きなのか、どのように調理されるのかを説明してください。',
          language: language,
          difficulty: 2,
          keywords: ['食べ物', '料理', '味'],
          minWords: 60,
          maxWords: 180,
          imageUrl: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
        ),
      ];
    } else {
      return [
        WritingExercise(
          id: '1',
          title: 'Mi rutina diaria',
          prompt: 'Describe tu rutina diaria, incluyendo lo que haces por la mañana, tarde y noche.',
          language: language,
          difficulty: 1,
          keywords: ['rutina', 'diario', 'actividades'],
          minWords: 50,
          maxWords: 150,
          imageUrl: 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
        ),
        WritingExercise(
          id: '2',
          title: 'Mi comida favorita',
          prompt: 'Escribe sobre tu comida favorita y por qué te gusta tanto.',
          language: language,
          difficulty: 1,
          keywords: ['comida', 'favorita', 'gustar'],
          minWords: 50,
          maxWords: 150,
          imageUrl: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
        ),
        WritingExercise(
          id: '3',
          title: 'Mi lugar ideal para vacacionar',
          prompt: 'Describe tu lugar ideal para vacacionar y qué actividades te gustaría hacer allí.',
          language: language,
          difficulty: 2,
          keywords: ['vacaciones', 'lugar', 'actividades'],
          minWords: 80,
          maxWords: 200,
          imageUrl: 'https://images.unsplash.com/photo-1503917988258-f87a78e3c995?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
        ),
      ];
    }
  }
}