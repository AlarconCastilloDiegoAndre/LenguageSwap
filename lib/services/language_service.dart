import 'package:flutter/material.dart';

class LanguageService extends ChangeNotifier {
  // Idioma seleccionado por defecto
  String _selectedLanguage = 'Japonés';
  
  // Getter para obtener el idioma actual
  String get selectedLanguage => _selectedLanguage;
  
  // Lista de idiomas disponibles
  final List<String> availableLanguages = [
    'Japonés',
    'Inglés',
    'Francés',
    'Alemán',
    'Italiano'
  ];
  
  // Método para cambiar el idioma
  void changeLanguage(String language) {
    if (availableLanguages.contains(language)) {
      _selectedLanguage = language;
      notifyListeners();
    }
  }
}