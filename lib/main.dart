import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'features/authentication/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'services/language_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Configuramos la orientación de la pantalla
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Ejecutamos la aplicación con MultiProvider
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageService()),
        // Otros providers si los hay
      ],
      child: const LanguageSwapApp(),
    ),
  );
}

class LanguageSwapApp extends StatelessWidget {
  const LanguageSwapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( // Definimos un tema de la aplicación con colores azules
      title: 'LanguageSwap',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed( // Colores principales
          seedColor: Colors.blue,
          secondary: Colors.lightBlue,
        ),
        useMaterial3: true, // El material 3 nos da un aspecto más moderno
        fontFamily: 'Roboto',
        inputDecorationTheme: InputDecorationTheme( // Estilo de los campos de texto
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData( // Estilo de los botones
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginScreen(), // Pantalla de inicio de sesión, que va a ser la inicial
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LanguageSwap',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginScreen(),
    );
  }
}