import 'package:flutter/material.dart';
import 'exercise_cards_screen.dart';

class ItalianVocabularyScreen extends StatelessWidget {
  const ItalianVocabularyScreen({super.key});

  List<Map<String, String>> _getItalianVocabulary() {
    return [
      {
        'word': 'Ciao',
        'translation': 'Hola',
        'pronunciation': 'CHAO',
      },
      {
        'word': 'Arrivederci',
        'translation': 'Adiós',
        'pronunciation': 'a-ri-ve-DER-chi',
      },
      {
        'word': 'Grazie',
        'translation': 'Gracias',
        'pronunciation': 'GRA-tsie',
      },
      {
        'word': 'Per favore',
        'translation': 'Por favor',
        'pronunciation': 'per fa-VO-re',
      },
      {
        'word': 'Amico',
        'translation': 'Amigo',
        'pronunciation': 'a-MI-ko',
      },
      {
        'word': 'Famiglia',
        'translation': 'Familia',
        'pronunciation': 'fa-MI-lia',
      },
      {
        'word': 'Amore',
        'translation': 'Amor',
        'pronunciation': 'a-MO-re',
      },
      {
        'word': 'Cibo',
        'translation': 'Comida',
        'pronunciation': 'CHI-bo',
      },
      {
        'word': 'Acqua',
        'translation': 'Agua',
        'pronunciation': 'A-kua',
      },
      {
        'word': 'Tempo',
        'translation': 'Tiempo',
        'pronunciation': 'TEM-po',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ExerciseCardsScreen(
      vocabulary: _getItalianVocabulary(),
      language: 'Italiano',
    );
  }
}