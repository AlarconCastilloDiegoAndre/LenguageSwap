import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/language_service.dart';
import 'exercise_cards_screen.dart';
import 'writing_exercise_screen.dart';
import 'english_writing_screen.dart';
import 'french_writing_screen.dart';
import 'german_writing_screen.dart';
import 'italian_writing_screen.dart';
import 'english_vocabulary_screen.dart';
import 'french_vocabulary_screen.dart';
import 'german_vocabulary_screen.dart';
import 'italian_vocabulary_screen.dart';

class DailyExercisesScreen extends StatelessWidget {
  const DailyExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejercicios Diarios'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Consumer<LanguageService>(
              builder: (context, languageService, child) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: languageService.selectedLanguage,
                      icon: const Icon(Icons.arrow_drop_down, color: Colors.blue),
                      elevation: 16,
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                      dropdownColor: Colors.blue.shade50,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          languageService.changeLanguage(newValue);
                        }
                      },
                      items: languageService.availableLanguages
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ejercicios Diarios',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Progreso diario
            _buildProgressCard(),
            const SizedBox(height: 24),
            
            // Ejercicios disponibles
            const Text(
              'Ejercicios Disponibles',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            Expanded(
              child: ListView(
                children: [
                  _buildExerciseCard(
                    'Vocabulario Básico',
                    'Aprende 10 palabras nuevas',
                    Icons.school,
                    Colors.blue,
                    0.7,
                    onTap: () {
                      final language = context.read<LanguageService>().selectedLanguage;
                      if (language == 'Japonés') {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ExerciseCardsScreen(
                              vocabulary: _getVocabularyExercises('Japonés'),
                              language: 'Japonés',
                            ),
                          ),
                        );
                      } else if (language == 'Francés') {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const FrenchVocabularyScreen(),
                          ),
                        );
                      } else if (language == 'Alemán') {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const GermanVocabularyScreen(),
                          ),
                        );
                      } else if (language == 'Italiano') {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ItalianVocabularyScreen(),
                          ),
                        );
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const EnglishVocabularyScreen(),
                          ),
                        );
                      }
                    },
                  ),
                  _buildExerciseCard(
                    'Pronunciación',
                    'Practica la pronunciación de 5 frases',
                    Icons.record_voice_over,
                    Colors.orange,
                    0.3,
                    onTap: () {
                      // Implementación de navegación para ejercicio de pronunciación
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Ejercicio de pronunciación próximamente')),
                      );
                    },
                  ),
                  _buildExerciseCard(
                    'Escritura',
                    'Practica escribiendo 3 caracteres',
                    Icons.edit,
                    Colors.green,
                    0.0,
                    onTap: () {
                      final language = context.read<LanguageService>().selectedLanguage;
                      if (language == 'Japonés') {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const WritingExerciseScreen(),
                          ),
                        );
                      } else if (language == 'Francés') {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const FrenchWritingScreen(),
                          ),
                        );
                      } else if (language == 'Alemán') {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const GermanWritingScreen(),
                          ),
                        );
                      } else if (language == 'Italiano') {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ItalianWritingScreen(),
                          ),
                        );
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const EnglishWritingScreen(),
                          ),
                        );
                      }
                    },
                  ),
                  _buildExerciseCard(
                    'Comprensión',
                    'Escucha y comprende 2 diálogos cortos',
                    Icons.hearing,
                    Colors.purple,
                    0.0,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Ejercicios de comprensión próximamente'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildProgressCard() {
    return Card(
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Progreso de Hoy',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '2/4 completados',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: 0.5,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              minHeight: 10,
              borderRadius: BorderRadius.circular(5),
            ),
            const SizedBox(height: 12),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Racha actual: 5 días'),
                Text('Meta: 7 días'),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildExerciseCard(
    String title,
    String description,
    IconData icon,
    Color color,
    double progress, {
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: color.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Icon(icon, color: color, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(color),
                minHeight: 8,
                borderRadius: BorderRadius.circular(4),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${(progress * 100).toInt()}% Completado',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  TextButton(
                    onPressed: onTap,
                    style: TextButton.styleFrom(
                      foregroundColor: color,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      progress > 0 ? 'Continuar' : 'Comenzar',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Map<String, String>> _getVocabularyExercises(String language) {
    switch (language) {
      case 'Inglés':
        return [
          {'word': 'Hello', 'translation': 'Hola', 'pronunciation': 'he-LOU'},
          {'word': 'Goodbye', 'translation': 'Adiós', 'pronunciation': 'gud-BAI'},
          {'word': 'Thank you', 'translation': 'Gracias', 'pronunciation': 'zank-IU'},
          {'word': 'Please', 'translation': 'Por favor', 'pronunciation': 'pli:z'},
          {'word': 'Friend', 'translation': 'Amigo', 'pronunciation': 'frend'},
          {'word': 'Family', 'translation': 'Familia', 'pronunciation': 'FA-mi-li'},
          {'word': 'Love', 'translation': 'Amor', 'pronunciation': 'lav'},
          {'word': 'Food', 'translation': 'Comida', 'pronunciation': 'fu:d'},
          {'word': 'Water', 'translation': 'Agua', 'pronunciation': 'WO-ter'},
          {'word': 'Time', 'translation': 'Tiempo', 'pronunciation': 'taim'},
        ];
      case 'Francés':
        return [
          {'word': 'Bonjour', 'translation': 'Hola', 'pronunciation': 'bon-ZHUR'},
          {'word': 'Au revoir', 'translation': 'Adiós', 'pronunciation': 'o-re-VUAR'},
          {'word': 'Merci', 'translation': 'Gracias', 'pronunciation': 'mer-SI'},
          {'word': "S'il vous plaît", 'translation': 'Por favor', 'pronunciation': 'sil-vu-PLE'},
          {'word': 'Ami', 'translation': 'Amigo', 'pronunciation': 'a-MI'},
          {'word': 'Famille', 'translation': 'Familia', 'pronunciation': 'fa-MI-ye'},
          {'word': 'Amour', 'translation': 'Amor', 'pronunciation': 'a-MUR'},
          {'word': 'Nourriture', 'translation': 'Comida', 'pronunciation': 'nu-ri-TUR'},
          {'word': 'Eau', 'translation': 'Agua', 'pronunciation': 'O'},
          {'word': 'Temps', 'translation': 'Tiempo', 'pronunciation': 'tan'},
        ];
      case 'Alemán':
        return [
          {'word': 'Hallo', 'translation': 'Hola', 'pronunciation': 'HA-lo'},
          {'word': 'Auf Wiedersehen', 'translation': 'Adiós', 'pronunciation': 'auf-VI-der-zen'},
          {'word': 'Danke', 'translation': 'Gracias', 'pronunciation': 'DAN-ke'},
          {'word': 'Bitte', 'translation': 'Por favor', 'pronunciation': 'BI-te'},
          {'word': 'Freund', 'translation': 'Amigo', 'pronunciation': 'froint'},
          {'word': 'Familie', 'translation': 'Familia', 'pronunciation': 'fa-MI-lie'},
          {'word': 'Liebe', 'translation': 'Amor', 'pronunciation': 'LI-be'},
          {'word': 'Essen', 'translation': 'Comida', 'pronunciation': 'E-sen'},
          {'word': 'Wasser', 'translation': 'Agua', 'pronunciation': 'VA-ser'},
          {'word': 'Zeit', 'translation': 'Tiempo', 'pronunciation': 'tsait'},
        ];
      case 'Italiano':
        return [
          {'word': 'Ciao', 'translation': 'Hola', 'pronunciation': 'CHAO'},
          {'word': 'Arrivederci', 'translation': 'Adiós', 'pronunciation': 'a-ri-ve-DER-chi'},
          {'word': 'Grazie', 'translation': 'Gracias', 'pronunciation': 'GRA-tsie'},
          {'word': 'Per favore', 'translation': 'Por favor', 'pronunciation': 'per fa-VO-re'},
          {'word': 'Amico', 'translation': 'Amigo', 'pronunciation': 'a-MI-ko'},
          {'word': 'Famiglia', 'translation': 'Familia', 'pronunciation': 'fa-MI-lia'},
          {'word': 'Amore', 'translation': 'Amor', 'pronunciation': 'a-MO-re'},
          {'word': 'Cibo', 'translation': 'Comida', 'pronunciation': 'CHI-bo'},
          {'word': 'Acqua', 'translation': 'Agua', 'pronunciation': 'A-kua'},
          {'word': 'Tempo', 'translation': 'Tiempo', 'pronunciation': 'TEM-po'},
        ];
      default: // Japonés
        return [
          {'word': 'こんにちは', 'translation': 'Hola', 'pronunciation': 'Konnichiwa'},
          {'word': 'さようなら', 'translation': 'Adiós', 'pronunciation': 'Sayounara'},
          {'word': 'ありがとう', 'translation': 'Gracias', 'pronunciation': 'Arigatou'},
          {'word': 'お願いします', 'translation': 'Por favor', 'pronunciation': 'Onegaishimasu'},
          {'word': '友達', 'translation': 'Amigo', 'pronunciation': 'Tomodachi'},
          {'word': '家族', 'translation': 'Familia', 'pronunciation': 'Kazoku'},
          {'word': '愛', 'translation': 'Amor', 'pronunciation': 'Ai'},
          {'word': '食べ物', 'translation': 'Comida', 'pronunciation': 'Tabemono'},
          {'word': '水', 'translation': 'Agua', 'pronunciation': 'Mizu'},
          {'word': '時間', 'translation': 'Tiempo', 'pronunciation': 'Jikan'},
        ];
    }
  }
}