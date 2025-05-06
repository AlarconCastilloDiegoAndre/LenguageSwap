import 'package:flutter/material.dart';
import 'exercise_cards_screen.dart';

class GermanVocabularyScreen extends StatelessWidget {
  const GermanVocabularyScreen({super.key});

  List<Map<String, String>> _getGermanVocabulary() {
    return [
      {
        'word': 'Hallo',
        'translation': 'Hola',
        'pronunciation': 'HA-lo',
      },
      {
        'word': 'Auf Wiedersehen',
        'translation': 'Adiós',
        'pronunciation': 'auf-VI-der-zen',
      },
      {
        'word': 'Danke',
        'translation': 'Gracias',
        'pronunciation': 'DAN-ke',
      },
      {
        'word': 'Bitte',
        'translation': 'Por favor',
        'pronunciation': 'BI-te',
      },
      {
        'word': 'Freund',
        'translation': 'Amigo',
        'pronunciation': 'froynt',
      },
      {
        'word': 'Familie',
        'translation': 'Familia',
        'pronunciation': 'fa-MI-lie',
      },
      {
        'word': 'Liebe',
        'translation': 'Amor',
        'pronunciation': 'LI-be',
      },
      {
        'word': 'Essen',
        'translation': 'Comida',
        'pronunciation': 'E-sen',
      },
      {
        'word': 'Wasser',
        'translation': 'Agua',
        'pronunciation': 'VA-ser',
      },
      {
        'word': 'Zeit',
        'translation': 'Tiempo',
        'pronunciation': 'tsait',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ExerciseCardsScreen(
      vocabulary: _getGermanVocabulary(),
      language: 'Alemán',
    );
  }
}