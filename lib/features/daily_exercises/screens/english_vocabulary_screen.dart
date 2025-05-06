import 'package:flutter/material.dart';

class EnglishVocabularyScreen extends StatefulWidget {
  const EnglishVocabularyScreen({super.key});

  @override
  State<EnglishVocabularyScreen> createState() => _EnglishVocabularyScreenState();
}

class _EnglishVocabularyScreenState extends State<EnglishVocabularyScreen> {
  final List<Map<String, String>> vocabularyCards = [
    {
      'word': 'House',
      'translation': 'Casa',
      'example': 'I live in a big house.',
      'pronunciation': 'haʊs',
    },
    {
      'word': 'Work',
      'translation': 'Trabajo',
      'example': 'I need to go to work.',
      'pronunciation': 'wɜːk',
    },
    {
      'word': 'Food',
      'translation': 'Comida',
      'example': 'The food is delicious.',
      'pronunciation': 'fuːd',
    },
    // Agrega más palabras según sea necesario
  ];

  int currentCardIndex = 0;
  bool isFlipped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vocabulario en Inglés'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Progreso
            Text(
              'Palabra ${currentCardIndex + 1} de ${vocabularyCards.length}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),

            // Tarjeta
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isFlipped = !isFlipped;
                  });
                },
                child: Card(
                  elevation: 5,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (!isFlipped) ...[
                          Text(
                            vocabularyCards[currentCardIndex]['word']!,
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            vocabularyCards[currentCardIndex]['pronunciation']!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ] else ...[
                          Text(
                            vocabularyCards[currentCardIndex]['translation']!,
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            vocabularyCards[currentCardIndex]['example']!,
                            style: const TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Controles de navegación
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: currentCardIndex > 0
                        ? () {
                            setState(() {
                              currentCardIndex--;
                              isFlipped = false;
                            });
                          }
                        : null,
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Anterior'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: currentCardIndex < vocabularyCards.length - 1
                        ? () {
                            setState(() {
                              currentCardIndex++;
                              isFlipped = false;
                            });
                          }
                        : null,
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Siguiente'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}