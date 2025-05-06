import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/language_service.dart';
import '../../writing/screens/writing_screen.dart';

class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({super.key});

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  int completedExercises = 2;
  int totalExercises = 4;
  int currentStreak = 5;
  int targetStreak = 7;
  
  @override
  Widget build(BuildContext context) {
    final languageService = Provider.of<LanguageService>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('LanguageSwap'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        // Elimina el widget 'actions' con el DropdownButton
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
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Progreso de Hoy',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$completedExercises/$totalExercises completados',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: completedExercises / totalExercises,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Racha actual: $currentStreak días',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Meta: $targetStreak días',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Título de ejercicios disponibles
            const Text(
              'Ejercicios Disponibles',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
            // Lista de ejercicios
            Expanded(
              child: ListView(
                children: [
                  _buildExerciseCard(
                    icon: Icons.record_voice_over,
                    color: Colors.orange,
                    title: 'Pronunciación',
                    description: 'Practica la pronunciación de 5 frases',
                    progress: 0.7,
                    isCompleted: true,
                    onTap: () {
                      // Navegar a ejercicio de pronunciación
                    },
                  ),
                  const SizedBox(height: 8),
                  _buildExerciseCard(
                    icon: Icons.edit,
                    color: Colors.green,
                    title: 'Escritura',
                    description: 'Practica escribiendo 3 caracteres',
                    progress: 0.0,
                    isCompleted: false,
                    onTap: () {
                      // Navegar a ejercicio de escritura
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WritingScreen(
                            language: languageService.selectedLanguage,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  _buildExerciseCard(
                    icon: Icons.hearing,
                    color: Colors.purple,
                    title: 'Comprensión',
                    description: 'Escucha y comprende 2 diálogos cortos',
                    progress: 0.0,
                    isCompleted: false,
                    onTap: () {
                      // Navegar a ejercicio de comprensión
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

  Widget _buildExerciseCard({
    required IconData icon,
    required Color color,
    required String title,
    required String description,
    required double progress,
    required bool isCompleted,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      icon,
                      color: color,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
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
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(color),
                minHeight: 6,
                borderRadius: BorderRadius.circular(3),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  isCompleted ? 'Continuar' : 'Comenzar',
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}