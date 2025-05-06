import 'package:flutter/material.dart';
import '../models/ranking_user.dart';
import '../services/ranking_service.dart';

class RankingScreen extends StatefulWidget {
  const RankingScreen({super.key});

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  final RankingService _rankingService = RankingService();
  List<RankingUser> _users = [];
  bool _isLoading = true;
  String _selectedPeriod = 'Semanal';
  String _selectedLanguage = 'Japonés';

  @override
  void initState() {
    super.initState();
    _loadRankingData();
  }

  Future<void> _loadRankingData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      print('Cargando datos de ranking para idioma: $_selectedLanguage');
      // Pasar el idioma seleccionado al servicio
      final users = await _rankingService.getRankingUsers(language: _selectedLanguage);
      
      print('Datos cargados. Número de usuarios: ${users.length}');
      
      // Ordenar usuarios por puntos (de mayor a menor)
      users.sort((a, b) => b.points.compareTo(a.points));
      
      setState(() {
        _users = users;
        _isLoading = false;
      });
    } catch (e) {
      print('Error al cargar datos de ranking: $e');
      setState(() {
        _isLoading = false;
        _users = []; // Asegurarse de que la lista esté vacía en caso de error
      });
      
      // Mostrar un mensaje de error al usuario
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al cargar datos de ranking: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ranking Global',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          
          // Filtros de ranking
          _buildRankingFilters(),
          const SizedBox(height: 8),
          
          // Mostrar indicador de carga o contenido
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _users.isEmpty
                  ? const Center(
                      child: Text(
                        'No hay datos disponibles para este idioma',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : Expanded(
                      child: Column(
                        children: [
                          // Podio de ganadores
                          Container(
                            height: 220,
                            child: _buildWinnersPodium(_users.take(3).toList()),
                          ),
                          
                      // Espacio adicional
                      const SizedBox(height: 20),
                      
                      // Título de clasificación
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          'Clasificación',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      
                      // Lista de usuarios
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: _users.length,
                          itemBuilder: (context, index) {
                            return _buildRankingItem(index + 1, _users[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildRankingFilters() {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<String>(
            isExpanded: true,
            decoration: const InputDecoration(
              labelText: 'Periodo',
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            ),
            value: _selectedPeriod,
            items: ['Diario', 'Semanal', 'Mensual', 'De todos los tiempos']
                .map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _selectedPeriod = newValue;
                });
                // Recargar datos si es necesario
                _loadRankingData();
              }
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: DropdownButtonFormField<String>(
            isExpanded: true,
            decoration: const InputDecoration(
              labelText: 'Idioma',
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            ),
            value: _selectedLanguage,
            items: ['Todos', 'Japonés', 'Inglés', 'Francés', 'Alemán', 'Italiano']
                .map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _selectedLanguage = newValue;
                });
                // Recargar datos con el nuevo idioma
                _loadRankingData();
              }
            },
          ),
        ),
      ],
    );
  }
  
  Widget _buildWinnersPodium(List<RankingUser> topUsers) {
    if (topUsers.isEmpty) {
      return const Center(
        child: Text(
          'No hay suficientes datos para mostrar el podio',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      );
    }
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Segundo lugar
        if (topUsers.length > 1)
          _buildPodiumItem(
            topUsers[1],
            2,
            const Color(0xFFCFD8DC), // Color plata metálico
            height: 100,
          ),
        const SizedBox(width: 8),
        
        // Primer lugar
        if (topUsers.isNotEmpty)
          _buildPodiumItem(
            topUsers[0],
            1,
            const Color(0xFFFFD700), // Color oro brillante
            height: 110,
            showCrown: true,
          ),
        const SizedBox(width: 8),
        
        // Tercer lugar
        if (topUsers.length > 2)
          _buildPodiumItem(
            topUsers[2],
            3,
            const Color(0xFFCD7F32), // Color bronce auténtico
            height: 80,
          ),
      ],
    );
  }
  
  Widget _buildPodiumItem(
    RankingUser user,
    int position,
    Color color, {
    required double height,
    bool showCrown = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showCrown)
          const Icon(
            Icons.emoji_events,
            color: Colors.amber,
            size: 20, // Reducimos tamaño
          ),
        CircleAvatar(
          radius: 20, // Reducimos un poco
          backgroundColor: Colors.white,
          child: Text(
            user.name.substring(0, 1),
            style: TextStyle(
              fontSize: 16, // Reducimos un poco
              fontWeight: FontWeight.bold,
              color: color.withOpacity(0.8),
            ),
          ),
        ),
        const SizedBox(height: 2), // Menos espacio
        Text(
          user.name.split(' ')[0],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11, // Reducimos un poco
          ),
        ),
        Text(
          '${user.points} pts',
          style: TextStyle(
            fontSize: 9, // Reducimos un poco
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 2), // Menos espacio
        Container(
          width: 55, // Reducimos un poco
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
            ),
          ),
          child: Center(
            child: Text(
              '#$position',
              style: const TextStyle(
                fontSize: 16, // Reducimos un poco
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildRankingItem(int position, RankingUser user) {
    Color backgroundColor;
    Color textColor;
    
    if (position == 1) {
      backgroundColor = const Color(0xFFFFF9C4); // Fondo dorado suave
      textColor = const Color(0xFFB7950B); // Texto dorado oscuro
    } else if (position == 2) {
      backgroundColor = const Color(0xFFECEFF1); // Fondo plateado suave
      textColor = const Color(0xFF546E7A); // Texto plateado oscuro
    } else if (position == 3) {
      backgroundColor = const Color(0xFFEFEBE9); // Fondo bronce suave
      textColor = const Color(0xFF8D6E63); // Texto bronce oscuro
    } else {
      backgroundColor = Colors.white; // Fondo blanco para el resto
      textColor = Colors.blue.shade700; // Texto azul para mantener coherencia
    }
    
    return Card(
      elevation: position <= 3 ? 2 : 1, // Mayor elevación para los primeros tres
      margin: const EdgeInsets.only(bottom: 4),
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Row(
          children: [
            // Posición (sin círculo)
            SizedBox(
              width: 28,
              child: Center(
                child: Text(
                  '$position',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16, // Aumentamos un poco
                    color: textColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            
            // Avatar con borde de color según posición
            CircleAvatar(
              radius: 18,
              backgroundColor: position <= 3 ? textColor : Colors.blue.shade100,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.white,
                child: Text(
                  user.name.substring(0, 1),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            
            // Información del usuario
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: textColor,
                    ),
                  ),
                  Text(
                    'Nivel ${user.level} • Racha: ${user.streak} días',
                    style: TextStyle(
                      fontSize: 12,
                      color: position <= 3 ? textColor.withOpacity(0.7) : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            
            // Puntos con estilo especial para los primeros tres
            Text(
              '${user.points}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            Text(
              ' pts',
              style: TextStyle(
                fontSize: 12,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}