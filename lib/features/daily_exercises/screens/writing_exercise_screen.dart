import 'package:flutter/material.dart';

class WritingExerciseScreen extends StatefulWidget {
  const WritingExerciseScreen({super.key});

  @override
  State<WritingExerciseScreen> createState() => _WritingExerciseScreenState();
}

class _WritingExerciseScreenState extends State<WritingExerciseScreen> {
  final List<Map<String, String>> _characters = [
    {'character': 'あ', 'romaji': 'a', 'tipo': 'Hiragana'},
    {'character': 'い', 'romaji': 'i', 'tipo': 'Hiragana'},
    {'character': 'う', 'romaji': 'u', 'tipo': 'Hiragana'},
    {'character': 'え', 'romaji': 'e', 'tipo': 'Hiragana'},
    {'character': 'お', 'romaji': 'o', 'tipo': 'Hiragana'},
  ];
  
  int _currentIndex = 0;
  String _userInput = '';
  bool _showFeedback = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Práctica de Escritura'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Carácter ${_currentIndex + 1} de ${_characters.length}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            
            // Mostrar el carácter actual
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      _characters[_currentIndex]['character']!,
                      style: const TextStyle(fontSize: 72),
                    ),
                    Text(
                      'Tipo: ${_characters[_currentIndex]['tipo']}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Campo de entrada para el usuario
            TextField(
              decoration: InputDecoration(
                labelText: 'Escribe la pronunciación en romaji',
                hintText: 'Ejemplo: a, i, u, e, o',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _userInput = value.toLowerCase();
                });
              },
            ),
            
            const SizedBox(height: 20),
            
            // Botones de navegación
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (_currentIndex > 0)
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _currentIndex--;
                        _userInput = '';
                        _showFeedback = false;
                      });
                    },
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Anterior'),
                  ),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _showFeedback = true;
                      if (_userInput == _characters[_currentIndex]['romaji']) {
                        if (_currentIndex < _characters.length - 1) {
                          _currentIndex++;
                          _userInput = '';
                          _showFeedback = false;
                        }
                      }
                    });
                  },
                  icon: const Icon(Icons.check),
                  label: const Text('Verificar'),
                ),
              ],
            ),
            
            if (_showFeedback) ...[
              const SizedBox(height: 20),
              Text(
                _userInput == _characters[_currentIndex]['romaji']
                    ? '¡Correcto!'
                    : 'Intenta de nuevo. La respuesta correcta es: ${_characters[_currentIndex]['romaji']}',
                style: TextStyle(
                  color: _userInput == _characters[_currentIndex]['romaji']
                      ? Colors.green
                      : Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}