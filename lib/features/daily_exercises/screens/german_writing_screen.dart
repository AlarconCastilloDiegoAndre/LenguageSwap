import 'package:flutter/material.dart';

class GermanWritingScreen extends StatefulWidget {
  const GermanWritingScreen({super.key});

  @override
  State<GermanWritingScreen> createState() => _GermanWritingScreenState();
}

class _GermanWritingScreenState extends State<GermanWritingScreen> {
  final List<Map<String, String>> exercises = [
    {
      'prompt': 'Traduce: "Me llamo..."',
      'answer': 'Ich heiße...',
      'hint': 'Usa el verbo "heißen" en primera persona',
    },
    {
      'prompt': 'Completa: "Wie geht es ___?"',
      'answer': 'dir',
      'hint': 'Es el pronombre informal "te" en dativo',
    },
    {
      'prompt': 'Escribe: "Buenos días"',
      'answer': 'Guten Morgen',
      'hint': 'Es una frase compuesta: Guten (bueno) + Morgen (mañana)',
    },
    {
      'prompt': 'Traduce: "¿Dónde está...?"',
      'answer': 'Wo ist...?',
      'hint': 'Usa "wo" para preguntar dónde',
    },
    {
      'prompt': 'Completa: "Ich ___ Deutsch"',
      'answer': 'spreche',
      'hint': 'Es el verbo "sprechen" conjugado en primera persona',
    },
    {
      'prompt': 'Escribe: "Gracias"',
      'answer': 'Danke',
      'hint': 'Una de las palabras más importantes en alemán',
    },
    {
      'prompt': 'Traduce: "¿Cómo te llamas?"',
      'answer': 'Wie heißt du?',
      'hint': 'Usa el verbo "heißen" en segunda persona',
    },
    {
      'prompt': 'Completa: "Auf ___"',
      'answer': 'Wiedersehen',
      'hint': 'Es la forma de decir adiós',
    },
    {
      'prompt': 'Escribe: "Por favor"',
      'answer': 'Bitte',
      'hint': 'Es una palabra muy común y versátil',
    },
    {
      'prompt': 'Traduce: "Mucho gusto"',
      'answer': 'Freut mich',
      'hint': 'Literalmente significa "me alegra"',
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
        title: const Text('Ejercicios de Escritura en Alemán'),
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

            // Tarjeta del ejercicio
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

            // Campo de respuesta
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

            // Botones de acción
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