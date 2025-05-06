import 'package:flutter/material.dart';

class FlashcardsScreen extends StatelessWidget {
  const FlashcardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tarjetas de Vocabulario',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          // Buscador
          TextField(
            decoration: InputDecoration(
              hintText: 'Buscar tarjetas',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // Categorías
          const Text(
            'Categorías',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          
          // Lista horizontal de categorías
          SizedBox(
            height: 110,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildCategoryCard('Saludos', Icons.waving_hand, Colors.blue),
                _buildCategoryCard('Comida', Icons.restaurant, Colors.orange),
                _buildCategoryCard('Números', Icons.numbers, Colors.green),
                _buildCategoryCard('Viajes', Icons.flight, Colors.purple),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Tarjetas recientes
          const Text(
            'Tarjetas Recientes',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          
          Expanded(
            child: ListView(
              children: [
                _buildFlashcard('こんにちは', 'Hola', 'Konnichiwa'),
                _buildFlashcard('ありがとう', 'Gracias', 'Arigatou'),
                _buildFlashcard('お願いします', 'Por favor', 'Onegaishimasu'),
                _buildFlashcard('さようなら', 'Adiós', 'Sayounara'),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCategoryCard(String title, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        color: color.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon, 
            size: 36, 
            color: color,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildFlashcard(String japanese, String spanish, String pronunciation) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  japanese,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.volume_up),
                  onPressed: () {
                    // Reproducir pronunciación
                  },
                ),
              ],
            ),
            const Divider(),
            Text(
              spanish,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              'Pronunciación: $pronunciation',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}