import 'package:flutter/material.dart';

class EnglishWritingScreen extends StatefulWidget {
  const EnglishWritingScreen({super.key});

  @override
  State<EnglishWritingScreen> createState() => _EnglishWritingScreenState();
}

class _EnglishWritingScreenState extends State<EnglishWritingScreen> {
  final List<Map<String, String>> exercises = [
    {
      'prompt': 'Traduce: "Mi casa es grande"',
      'answer': 'My house is big',
      'hint': 'Recuerda que en inglés el adjetivo va después del verbo "to be"',
    },
    {
      'prompt': 'Completa: "I ___ to school every day"',
      'answer': 'go',
      'hint': 'Verbo que significa "ir" en presente simple',
    },
    {
      'prompt': 'Escribe: "¿Cómo te llamas?"',
      'answer': 'What is your name?',
      'hint': 'En inglés, el orden es: What + is + your + name',
    },
  ];

  int currentExerciseIndex = 0;
  final TextEditingController _answerController = TextEditingController();
  bool showHint = false;
  bool showResult = false;
  bool isCorrect = false;

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  void checkAnswer() {
    setState(() {
      isCorrect = _answerController.text.trim().toLowerCase() ==
          exercises[currentExerciseIndex]['answer']!.toLowerCase();
      showResult = true;
    });
  }

  void nextExercise() {
    if (currentExerciseIndex < exercises.length - 1) {
      setState(() {
        currentExerciseIndex++;
        _answerController.clear();
        showHint = false;
        showResult = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejercicios de Escritura'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ejercicio ${currentExerciseIndex + 1} de ${exercises.length}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),

            // Prompt
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exercises[currentExerciseIndex]['prompt']!,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (showHint) ...[
                      const SizedBox(height: 12),
                      Text(
                        'Pista: ${exercises[currentExerciseIndex]['hint']!}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Input
            TextField(
              controller: _answerController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Tu respuesta',
                hintText: 'Escribe tu respuesta aquí',
              ),
              onSubmitted: (_) => checkAnswer(),
            ),
            const SizedBox(height: 16),

            // Botones
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      showHint = !showHint;
                    });
                  },
                  icon: const Icon(Icons.lightbulb_outline),
                  label: const Text('Ver Pista'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: checkAnswer,
                  icon: const Icon(Icons.check),
                  label: const Text('Verificar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Resultado
            if (showResult)
              Card(
                color: isCorrect ? Colors.green[50] : Colors.red[50],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isCorrect ? '¡Correcto!' : 'Incorrecto',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isCorrect ? Colors.green : Colors.red,
                        ),
                      ),
                      if (!isCorrect) ...[
                        const SizedBox(height: 8),
                        Text(
                          'Respuesta correcta: ${exercises[currentExerciseIndex]['answer']}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

            const Spacer(),

            // Botón siguiente
            if (showResult && currentExerciseIndex < exercises.length - 1)
              Center(
                child: ElevatedButton.icon(
                  onPressed: nextExercise,
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Siguiente Ejercicio'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}