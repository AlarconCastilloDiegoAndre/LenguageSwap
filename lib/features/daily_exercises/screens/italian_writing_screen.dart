import 'package:flutter/material.dart';

class ItalianWritingScreen extends StatefulWidget {
  const ItalianWritingScreen({super.key});

  @override
  State<ItalianWritingScreen> createState() => _ItalianWritingScreenState();
}

class _ItalianWritingScreenState extends State<ItalianWritingScreen> {
  final List<Map<String, String>> exercises = [
    {
      'prompt': 'Traduce: "Me llamo..."',
      'answer': 'Mi chiamo...',
      'hint': 'Usa el verbo "chiamarsi" en primera persona',
    },
    {
      'prompt': 'Completa: "Come ___ va?"',
      'answer': 'ti',
      'hint': 'Es el pronombre informal "te" en italiano',
    },
    {
      'prompt': 'Escribe: "Buenos días"',
      'answer': 'Buongiorno',
      'hint': 'Es una palabra compuesta: buon + giorno',
    },
    {
      'prompt': 'Traduce: "¿Dónde está...?"',
      'answer': 'Dov\'è...?',
      'hint': 'Usa "dov\'è" para preguntar dónde está',
    },
    {
      'prompt': 'Completa: "Io ___ italiano"',
      'answer': 'parlo',
      'hint': 'Es el verbo "parlare" conjugado en primera persona',
    },
    {
      'prompt': 'Escribe: "Gracias"',
      'answer': 'Grazie',
      'hint': 'Una de las palabras más importantes en italiano',
    },
    {
      'prompt': 'Traduce: "¿Cómo te llamas?"',
      'answer': 'Come ti chiami?',
      'hint': 'Usa el verbo "chiamarsi" en segunda persona',
    },
    {
      'prompt': 'Completa: "Ci ___"',
      'answer': 'vediamo',
      'hint': 'Es la forma de decir "nos vemos"',
    },
    {
      'prompt': 'Escribe: "Por favor"',
      'answer': 'Per favore',
      'hint': 'Es una frase de cortesía muy común',
    },
    {
      'prompt': 'Traduce: "Mucho gusto"',
      'answer': 'Piacere',
      'hint': 'Se usa al conocer a alguien nuevo',
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
        title: const Text('Ejercicios de Escritura en Italiano'),
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