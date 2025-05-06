import 'package:flutter/material.dart';
import '../models/writing_exercise.dart';

class WritingExerciseDetailScreen extends StatefulWidget {
  final WritingExercise exercise;
  
  const WritingExerciseDetailScreen({
    super.key,
    required this.exercise,
  });

  @override
  State<WritingExerciseDetailScreen> createState() => _WritingExerciseDetailScreenState();
}

class _WritingExerciseDetailScreenState extends State<WritingExerciseDetailScreen> {
  final TextEditingController _textController = TextEditingController();
  int _wordCount = 0;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _textController.addListener(_updateWordCount);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _updateWordCount() {
    final text = _textController.text.trim();
    setState(() {
      _wordCount = text.isEmpty ? 0 : text.split(RegExp(r'\s+')).length;
    });
  }

  void _submitExercise() {
    if (_wordCount < widget.exercise.minWords) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor escribe al menos ${widget.exercise.minWords} palabras'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    // Simular envío del ejercicio
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isSubmitting = false;
      });
      
      // Mostrar diálogo de éxito
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('¡Ejercicio completado!'),
          content: const Text('Tu ejercicio ha sido enviado correctamente. Recibirás retroalimentación pronto.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cerrar diálogo
                Navigator.pop(context); // Volver a la lista de ejercicios
              },
              child: const Text('Aceptar'),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exercise.title),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del ejercicio
            if (widget.exercise.imageUrl.isNotEmpty)
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: widget.exercise.imageUrl.startsWith('http')
                        ? NetworkImage(widget.exercise.imageUrl) as ImageProvider
                        : AssetImage(widget.exercise.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(height: 16),
            
            // Información del ejercicio
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título
                    Text(
                      widget.exercise.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    
                    // Dificultad
                    Row(
                      children: [
                        const Text(
                          'Dificultad: ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ...List.generate(
                          widget.exercise.difficulty,
                          (index) => const Icon(Icons.star, size: 16, color: Colors.amber),
                        ),
                        ...List.generate(
                          3 - widget.exercise.difficulty,
                          (index) => const Icon(Icons.star_border, size: 16, color: Colors.amber),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    
                    // Palabras requeridas
                    Text(
                      'Palabras requeridas: ${widget.exercise.minWords}-${widget.exercise.maxWords}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Prompt
                    Text(
                      widget.exercise.prompt,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Palabras clave
                    if (widget.exercise.keywords.isNotEmpty) ...[
                      const Text(
                        'Palabras clave:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: widget.exercise.keywords.map((keyword) {
                          return Chip(
                            label: Text(keyword),
                            backgroundColor: Colors.blue.shade100,
                          );
                        }).toList(),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Campo de texto para la respuesta
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tu respuesta:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _textController,
                      maxLines: 10,
                      decoration: InputDecoration(
                        hintText: 'Escribe tu respuesta aquí...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Palabras: $_wordCount/${widget.exercise.maxWords}',
                          style: TextStyle(
                            color: _wordCount < widget.exercise.minWords
                                ? Colors.red
                                : _wordCount > widget.exercise.maxWords
                                    ? Colors.orange
                                    : Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _isSubmitting ? null : _submitExercise,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade700,
                            foregroundColor: Colors.white,
                          ),
                          child: _isSubmitting
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text('Enviar'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}