import 'package:flutter/material.dart';
import 'dart:math' as math;

class ExerciseCard {
  final String question;
  final String answer;
  final String pronunciation;
  bool isFlipped;
  
  ExerciseCard({
    required this.question,
    required this.answer,
    required this.pronunciation,
    this.isFlipped = false,
  });
}

class ExerciseCardsScreen extends StatefulWidget {
  final List<Map<String, String>> vocabulary;
  final String language;

  const ExerciseCardsScreen({
    super.key,
    required this.vocabulary,
    required this.language,
  });

  @override
  State<ExerciseCardsScreen> createState() => _ExerciseCardsScreenState();
}

class _ExerciseCardsScreenState extends State<ExerciseCardsScreen> {
  late List<ExerciseCard> _cards;
  int _currentCardIndex = 0;
  int _correctAnswers = 0;
  bool _isExerciseComplete = false;

  @override
  void initState() {
    super.initState();
    _cards = widget.vocabulary.map((item) => ExerciseCard(
      question: item['word']!,
      answer: item['translation']!,
      pronunciation: item['pronunciation']!,
    )).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vocabulario en ${widget.language}'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: _isExerciseComplete 
          ? _buildResultScreen() 
          : _buildExerciseScreen(),
    );
  }
  
  Widget _buildExerciseScreen() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          LinearProgressIndicator(
            value: (_currentCardIndex + 1) / widget.vocabulary.length,
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            minHeight: 10,
            borderRadius: BorderRadius.circular(5),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Tarjeta ${_currentCardIndex + 1} de ${widget.vocabulary.length}',
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 16),
          
          Expanded(
            child: Center(
              child: FlipCard(
                card: _cards[_currentCardIndex],
                onFlip: () {},
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: _currentCardIndex > 0
                    ? () {
                        setState(() {
                          _currentCardIndex--;
                          _cards[_currentCardIndex].isFlipped = false;
                        });
                      }
                    : null,
                icon: const Icon(Icons.arrow_back),
                label: const Text('Anterior'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    if (_currentCardIndex < _cards.length - 1) {
                      _currentCardIndex++;
                      _correctAnswers++;
                      _cards[_currentCardIndex].isFlipped = false;
                    } else {
                      _correctAnswers++;
                      _isExerciseComplete = true;
                    }
                  });
                },
                icon: const Icon(Icons.check),
                label: const Text('Correcto'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    if (_currentCardIndex < _cards.length - 1) {
                      _currentCardIndex++;
                      _cards[_currentCardIndex].isFlipped = false;
                    } else {
                      _isExerciseComplete = true;
                    }
                  });
                },
                icon: const Icon(Icons.close),
                label: const Text('Incorrecto'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildResultScreen() {
    final percentage = (_correctAnswers / widget.vocabulary.length) * 100;
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 80,
            ),
            const SizedBox(height: 24),
            const Text(
              '¡Ejercicio Completado!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Has respondido correctamente $_correctAnswers de ${widget.vocabulary.length} tarjetas',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              '${percentage.toStringAsFixed(0)}% de aciertos',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: percentage >= 70 ? Colors.green : Colors.orange,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Volver a Ejercicios'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                setState(() {
                  _currentCardIndex = 0;
                  _correctAnswers = 0;
                  _isExerciseComplete = false;
                  for (var card in _cards) {
                    card.isFlipped = false;
                  }
                });
              },
              child: const Text('Intentar de nuevo'),
            ),
          ],
        ),
      ),
    );
  }
}

class FlipCard extends StatefulWidget {
  final ExerciseCard card;
  final VoidCallback onFlip;
  
  const FlipCard({
    super.key,
    required this.card,
    required this.onFlip,
  });

  @override
  State<FlipCard> createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.card.isFlipped = true;
          widget.onFlip();
        } else if (status == AnimationStatus.dismissed) {
          widget.card.isFlipped = false;
        }
      });
      
    // Aseguramos que la tarjeta comience sin voltear
    if (widget.card.isFlipped) {
      widget.card.isFlipped = false;
      _controller.reset();
    }
  }
  
  @override
  void didUpdateWidget(FlipCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Si cambiamos a una nueva tarjeta, aseguramos que esté en su estado inicial
    if (oldWidget.card != widget.card) {
      widget.card.isFlipped = false;
      _controller.reset();
    }
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  void _flip() {
    if (_animation.status == AnimationStatus.dismissed) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flip,
      child: SizedBox(
        width: double.infinity,
        height: 300,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            final angle = _animation.value * math.pi;
            final isBack = _animation.value >= 0.5;
            
            return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(angle),
              alignment: Alignment.center,
              child: isBack
                ? Transform(
                    transform: Matrix4.identity()..rotateY(math.pi),
                    alignment: Alignment.center,
                    child: _buildBackCard(),
                  )
                : _buildFrontCard(),
            );
          },
        ),
      ),
    );
  }
  
  Widget _buildFrontCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade300, Colors.blue.shade700],
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '¿Qué significa?',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              widget.card.question,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            const Icon(
              Icons.touch_app,
              color: Colors.white70,
              size: 40,
            ),
            const SizedBox(height: 8),
            const Text(
              'Toca para ver la respuesta',
              style: TextStyle(
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildBackCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.green.shade300, Colors.green.shade700],
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Significado',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              widget.card.answer,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Pronunciación',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.card.pronunciation,
              style: const TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            // Eliminamos los elementos que causan el desbordamiento
            const SizedBox(height: 24),
            // const Icon(
            //   Icons.touch_app,
            //   color: Colors.white70,
            //   size: 40,
            // ),
            // const SizedBox(height: 8),
            const Text(
              'Toca para volver',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}