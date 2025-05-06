import 'package:flutter/material.dart';
import 'exercise_cards_screen.dart';

class FrenchVocabularyScreen extends StatelessWidget {
  const FrenchVocabularyScreen({super.key});

  List<Map<String, String>> _getFrenchVocabulary() {
    return [
      {
        'word': 'Bonjour',
        'translation': 'Hola',
        'pronunciation': 'bon-ZHUR',
      },
      {
        'word': 'Au revoir',
        'translation': 'Adiós',
        'pronunciation': 'o-re-VUAR',
      },
      {
        'word': 'Merci',
        'translation': 'Gracias',
        'pronunciation': 'mer-SI',
      },
      {
        'word': "S'il vous plaît",
        'translation': 'Por favor',
        'pronunciation': 'sil-vu-PLE',
      },
      {
        'word': 'Ami',
        'translation': 'Amigo',
        'pronunciation': 'a-MI',
      },
      {
        'word': 'Famille',
        'translation': 'Familia',
        'pronunciation': 'fa-MI-ye',
      },
      {
        'word': 'Amour',
        'translation': 'Amor',
        'pronunciation': 'a-MUR',
      },
      {
        'word': 'Nourriture',
        'translation': 'Comida',
        'pronunciation': 'nu-ri-TUR',
      },
      {
        'word': 'Eau',
        'translation': 'Agua',
        'pronunciation': 'O',
      },
      {
        'word': 'Temps',
        'translation': 'Tiempo',
        'pronunciation': 'tan',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ExerciseCardsScreen(
      vocabulary: _getFrenchVocabulary(),
      language: 'Francés',
    );
  }
}