import 'package:flutter/material.dart';
import '../models/writing_exercise.dart';
import '../services/writing_service.dart';

class WritingScreen extends StatefulWidget {
  final String language;
  
  const WritingScreen({
    super.key,
    required this.language,
  });

  @override
  State<WritingScreen> createState() => _WritingScreenState();
}

class _WritingScreenState extends State<WritingScreen> {
  final WritingService _writingService = WritingService();
  List<WritingExercise> _exercises = [];
  bool _isLoading = true;
  int _selectedDifficulty = 0; // 0 = Todos, 1 = Principiante, 2 = Intermedio, 3 = Avanzado

  @override
  void initState() {
    super.initState();
    _loadExercises();
  }

  Future<void> _loadExercises() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final exercises = await _writingService.getWritingExercises(language: widget.language);
      
      // Filtrar por dificultad si no es "Todos"
      final filteredExercises = _selectedDifficulty == 0
          ? exercises
          : exercises.where((e) => e.difficulty == _selectedDifficulty).toList();
      
      setState(() {
        _exercises = filteredExercises;
        _isLoading = false;
      });
    } catch (e) {
      print('Error al cargar ejercicios: $e');
      setState(() {
        _isLoading = false;
      });
      
      // Mostrar un mensaje de error al usuario
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al cargar ejercicios: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ejercicios de Escritura - ${widget.language}'),
        // Eliminamos el botón de selección de idioma aquí
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filtro de dificultad
            DropdownButtonFormField<int>(
              isExpanded: true,
              decoration: const InputDecoration(
                labelText: 'Dificultad',
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                border: OutlineInputBorder(),
              ),
              value: _selectedDifficulty,
              items: const [
                DropdownMenuItem<int>(value: 0, child: Text('Todos los niveles')),
                DropdownMenuItem<int>(value: 1, child: Text('Principiante')),
                DropdownMenuItem<int>(value: 2, child: Text('Intermedio')),
                DropdownMenuItem<int>(value: 3, child: Text('Avanzado')),
              ],
              onChanged: (int? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedDifficulty = newValue;
                  });
                  // Recargar ejercicios con la nueva dificultad
                  _loadExercises();
                }
              },
            ),
            const SizedBox(height: 16),
            
            // Mostrar indicador de carga o contenido
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _exercises.isEmpty
                    ? const Center(
                        child: Text(
                          'No hay ejercicios disponibles para este idioma y nivel',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : Expanded(
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: _exercises.length,
                          itemBuilder: (context, index) {
                            return _buildExerciseCard(_exercises[index]);
                          },
                        ),
                      ),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseCard(WritingExercise exercise) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          // Navegar a la pantalla de detalle del ejercicio
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WritingExerciseDetailScreen(exercise: exercise),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del ejercicio
            Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                image: DecorationImage(
                  image: NetworkImage(exercise.imageUrl),
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) {
                    // Imagen de respaldo en caso de error
                    return;
                  },
                ),
              ),
              child: exercise.imageUrl.isEmpty
                  ? const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        size: 40,
                        color: Colors.grey,
                      ),
                    )
                  : null,
            ),
            
            // Contenido del ejercicio
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título
                  Text(
                    exercise.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  
                  // Dificultad
                  Row(
                    children: [
                      const Text(
                        'Dificultad: ',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      ...List.generate(
                        exercise.difficulty,
                        (index) => const Icon(Icons.star, size: 12, color: Colors.amber),
                      ),
                      ...List.generate(
                        3 - exercise.difficulty,
                        (index) => const Icon(Icons.star_border, size: 12, color: Colors.amber),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  
                  // Palabras
                  Text(
                    '${exercise.minWords}-${exercise.maxWords} palabras',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
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

// Pantalla de detalle del ejercicio
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
  
  @override
  void initState() {
    super.initState();
    _textController.addListener(_updateWordCount);
  }
  
  @override
  void dispose() {
    _textController.removeListener(_updateWordCount);
    _textController.dispose();
    super.dispose();
  }
  
  void _updateWordCount() {
    final text = _textController.text.trim();
    setState(() {
      _wordCount = text.isEmpty ? 0 : text.split(RegExp(r'\s+')).length;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exercise.title),
      ),
      body: Padding(
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
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(widget.exercise.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(height: 16),
            
            // Información del ejercicio
            Text(
              'Dificultad: ${_getDifficultyText(widget.exercise.difficulty)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
            // Prompt del ejercicio
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Instrucciones:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.exercise.prompt,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Palabras clave: ${widget.exercise.keywords.join(", ")}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Longitud: ${widget.exercise.minWords}-${widget.exercise.maxWords} palabras',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Campo de texto para la respuesta
            Expanded(
              child: TextField(
                controller: _textController,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  hintText: 'Escribe tu respuesta aquí...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
              ),
            ),
            const SizedBox(height: 8),
            
            // Contador de palabras
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Palabras: $_wordCount/${widget.exercise.maxWords}',
                  style: TextStyle(
                    fontSize: 16,
                    color: _isWordCountValid() ? Colors.black : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: _isWordCountValid() ? _submitExercise : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Enviar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  bool _isWordCountValid() {
    return _wordCount >= widget.exercise.minWords && _wordCount <= widget.exercise.maxWords;
  }
  
  void _submitExercise() {
    // Aquí iría la lógica para enviar el ejercicio
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('¡Ejercicio enviado con éxito!'),
        backgroundColor: Colors.green,
      ),
    );
    
    // Volver a la pantalla anterior
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
    });
  }
  
  String _getDifficultyText(int difficulty) {
    switch (difficulty) {
      case 1:
        return 'Principiante';
      case 2:
        return 'Intermedio';
      case 3:
        return 'Avanzado';
      default:
        return 'Desconocido';
    }
  }
}