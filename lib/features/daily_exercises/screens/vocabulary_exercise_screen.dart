import 'package:flutter/material.dart';

class VocabularyExerciseScreen extends StatefulWidget {
  final List<Map<String, String>> exercises;
  final String language;

  const VocabularyExerciseScreen({
    super.key,
    required this.exercises,
    required this.language,
  });

  @override
  State<VocabularyExerciseScreen> createState() => _VocabularyExerciseScreenState();
}

class _VocabularyExerciseScreenState extends State<VocabularyExerciseScreen> {
  int currentIndex = 0;
  bool showAnswer = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ejercicio de Vocabulario - ${widget.language}'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Barra de progreso
          LinearProgressIndicator(
            value: (currentIndex + 1) / widget.exercises.length,
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            minHeight: 10,
          ),
          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Tarjeta ${currentIndex + 1} de ${widget.exercises.length}',
              style: const TextStyle(fontSize: 16),
            ),
          ),

          // Espacio para la tarjeta
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    showAnswer = !showAnswer;
                  });
                },
                child: Card(
                  color: showAnswer ? Colors.green : Colors.blue,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            showAnswer ? 'Significado' : '¿Qué significa?',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            showAnswer 
                              ? widget.exercises[currentIndex]['translation']!
                              : widget.exercises[currentIndex]['word']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          if (showAnswer) ...[
                            const SizedBox(height: 20),
                            Text(
                              'Pronunciación',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              widget.exercises[currentIndex]['pronunciation']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                          const SizedBox(height: 20),
                          Icon(
                            Icons.touch_app,
                            color: Colors.white.withOpacity(0.8),
                            size: 30,
                          ),
                          Text(
                            showAnswer ? 'Toca para volver' : 'Toca para ver la respuesta',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Botones de navegación
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: currentIndex > 0
                      ? () {
                          setState(() {
                            currentIndex--;
                            showAnswer = false;
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
                  onPressed: () {
                    setState(() {
                      showAnswer = false;
                    });
                  },
                  icon: const Icon(Icons.check),
                  label: const Text('Correcto'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      showAnswer = false;
                    });
                  },
                  icon: const Icon(Icons.close),
                  label: const Text('Incorrecto'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: currentIndex < widget.exercises.length - 1
                      ? () {
                          setState(() {
                            currentIndex++;
                            showAnswer = false;
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
    );
  }
}