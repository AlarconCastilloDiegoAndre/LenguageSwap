import 'package:flutter/material.dart';

class WritingExerciseScreen extends StatefulWidget {
  const WritingExerciseScreen({super.key});

  @override
  State<WritingExerciseScreen> createState() => _WritingExerciseScreenState();
}

class _WritingExerciseScreenState extends State<WritingExerciseScreen> {
  final List<String> characters = ['あ', 'い', 'う', 'え', 'お'];
  int currentCharacterIndex = 0;
  bool showStrokeOrder = false;

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
            // Tarjeta del carácter actual
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      characters[currentCharacterIndex],
                      style: const TextStyle(
                        fontSize: 72,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Carácter ${currentCharacterIndex + 1} de ${characters.length}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Área de dibujo
            Container(
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  // Aquí irá el widget de dibujo
                  const Center(
                    child: Text('Área de práctica de escritura'),
                  ),
                  if (showStrokeOrder)
                    Container(
                      color: Colors.white.withOpacity(0.8),
                      child: const Center(
                        child: Text('Orden de trazos'),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Controles
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      showStrokeOrder = !showStrokeOrder;
                    });
                  },
                  icon: const Icon(Icons.help_outline),
                  label: const Text('Ver trazos'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Limpiar el área de dibujo
                  },
                  icon: const Icon(Icons.clear),
                  label: const Text('Borrar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Navegación
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: currentCharacterIndex > 0
                      ? () {
                          setState(() {
                            currentCharacterIndex--;
                          });
                        }
                      : null,
                  icon: const Icon(Icons.arrow_back),
                ),
                IconButton(
                  onPressed: currentCharacterIndex < characters.length - 1
                      ? () {
                          setState(() {
                            currentCharacterIndex++;
                          });
                        }
                      : null,
                  icon: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}