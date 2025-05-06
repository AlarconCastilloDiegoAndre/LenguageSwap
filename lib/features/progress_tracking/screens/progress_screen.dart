import 'package:flutter/material.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tu Progreso',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          // Resumen
          _buildSummaryCard(),
          const SizedBox(height: 24),
          
          // Estadísticas
          const Text(
            'Estadísticas',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          
          // Gráfico de barras simple
          Container(
            height: 200,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildBar('Lun', 0.3, Colors.blue),
                _buildBar('Mar', 0.5, Colors.blue),
                _buildBar('Mié', 0.7, Colors.blue),
                _buildBar('Jue', 0.4, Colors.blue),
                _buildBar('Vie', 0.6, Colors.blue),
                _buildBar('Sáb', 0.2, Colors.blue),
                _buildBar('Dom', 0.8, Colors.blue),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Palabras aprendidas
          const Text(
            'Palabras Aprendidas',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          
          Expanded(
            child: ListView(
              children: [
                _buildWordCard('こんにちは', 'Hola', 'Fácil'),
                _buildWordCard('ありがとう', 'Gracias', 'Fácil'),
                _buildWordCard('お願いします', 'Por favor', 'Medio'),
                _buildWordCard('さようなら', 'Adiós', 'Fácil'),
                _buildWordCard('いただきます', 'Buen provecho', 'Difícil'),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSummaryCard() {
    return Card(
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Resumen Semanal',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '75% completado',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatItem(value: '25', label: 'Palabras'),
                _StatItem(value: '12', label: 'Ejercicios'),
                _StatItem(value: '5', label: 'Días'),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildBar(String day, double height, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 30,
          height: 150 * height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        const SizedBox(height: 8),
        Text(day),
      ],
    );
  }
  
  Widget _buildWordCard(String japanese, String spanish, String difficulty) {
    Color difficultyColor;
    
    switch (difficulty) {
      case 'Fácil':
        difficultyColor = Colors.green;
        break;
      case 'Medio':
        difficultyColor = Colors.orange;
        break;
      case 'Difícil':
        difficultyColor = Colors.red;
        break;
      default:
        difficultyColor = Colors.grey;
    }
    
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(japanese),
        subtitle: Text(spanish),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: difficultyColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            difficulty,
            style: TextStyle(color: difficultyColor),
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  
  const _StatItem({
    required this.value,
    required this.label,
  });
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}