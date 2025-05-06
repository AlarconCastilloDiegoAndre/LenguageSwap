import 'package:flutter/material.dart';
import 'exercise_cards_screen.dart';

class EnglishVocabularyScreen extends StatelessWidget {
  const EnglishVocabularyScreen({super.key});

  List<Map<String, String>> _getEnglishVocabulary() {
    return [
      {
        'word': 'Hello',
        'translation': 'Hola',
        'pronunciation': '/həˈləʊ/',
      },
      {
        'word': 'Thank you',
        'translation': 'Gracias',
        'pronunciation': '/ˈθæŋk juː/',
      },
      {
        'word': 'Good morning',
        'translation': 'Buenos días',
        'pronunciation': '/ɡʊd ˈmɔːnɪŋ/',
      },
      {
        'word': 'Please',
        'translation': 'Por favor',
        'pronunciation': '/pliːz/',
      },
      {
        'word': 'Goodbye',
        'translation': 'Adiós',
        'pronunciation': '/ˌɡʊdˈbaɪ/',
      },
      {
        'word': 'How are you?',
        'translation': '¿Cómo estás?',
        'pronunciation': '/haʊ ɑː juː/',
      },
      {
        'word': 'Friend',
        'translation': 'Amigo',
        'pronunciation': '/frend/',
      },
      {
        'word': 'Family',
        'translation': 'Familia',
        'pronunciation': '/ˈfæmɪli/',
      },
      {
        'word': 'Water',
        'translation': 'Agua',
        'pronunciation': '/ˈwɔːtə/',
      },
      {
        'word': 'Food',
        'translation': 'Comida',
        'pronunciation': '/fuːd/',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ExerciseCardsScreen(
      vocabulary: _getEnglishVocabulary(),
      language: 'Inglés',
    );
  }
}