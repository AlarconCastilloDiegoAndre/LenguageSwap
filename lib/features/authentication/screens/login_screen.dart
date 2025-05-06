import 'package:flutter/material.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../../../features/home/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController(); //Contorlador de texto para el correo electrónico
  final _passwordController = TextEditingController(); //Contorlador de texto para la contraseña
  final _formKey = GlobalKey<FormState>(); //Clave para validar el formulario
  bool _isPasswordVisible = false; //Variable para mostrar u ocultar la contraseña

  // Credenciales predefinidas
  final String _validEmail = 'DiegoAndreAC@outlook.com';
  final String _validPassword = 'DAACx1yz!';

  @override
  void dispose() { //Limpiamos los controladores de texto
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() { //Función para iniciar sesión
    if (_formKey.currentState!.validate()) {
      // Verificamos si las credenciales son correctas
      if (_emailController.text == _validEmail && _passwordController.text == _validPassword) {
        // Credenciales correctas, navegamos a la pantalla principal
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        // Credenciales incorrectas, mostramos mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Correo o contraseña incorrectos'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(  //Aseguramos que el contenido no se superponga con la barra de notificaciones
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo y título
                  const Icon(
                    Icons.language,
                    size: 80,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'LanguageSwap',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Aprende idiomas intercambiando conocimientos',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 48),
                  
                  // Campos de formulario
                  CustomTextField( //Campo de correo electrónico
                    controller: _emailController,
                    hintText: 'Correo electrónico',
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) { //Validamos el correo electrónico
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu correo';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                        return 'Ingresa un correo válido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextField( //Campo de contraseña
                    controller: _passwordController,
                    hintText: 'Contraseña',
                    prefixIcon: Icons.lock_outline,
                    obscureText: !_isPasswordVisible,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () { //Mostramos u ocultamos la contraseña
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    validator: (value) { //Validamos la contraseña
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu contraseña';
                      }
                      if (value.length < 6) {
                        return 'La contraseña debe tener al menos 6 caracteres';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  
                  // Olvidé mi contraseña
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Navegar a la pantalla de recuperación de contraseña
                      },
                      child: const Text('¿Olvidaste tu contraseña?'),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Botón de inicio de sesión
                  ElevatedButton(
                    onPressed: _login,
                    child: const Text(
                      'Iniciar Sesión',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Separador
                  const Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text('O continúa con'),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Botones de redes sociales
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _socialButton(
                        icon: Icons.g_mobiledata,
                        color: Colors.red,
                        onPressed: () {
                          // Lógica para iniciar sesión con Google
                        },
                      ),
                      const SizedBox(width: 16),
                      _socialButton(
                        icon: Icons.facebook,
                        color: Colors.blue.shade800,
                        onPressed: () {
                          // Lógica para iniciar sesión con Facebook
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  
                  // Enlace para registrarse
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('¿No tienes una cuenta?'),
                      TextButton(
                        onPressed: () {
                          // Navegar a la pantalla de registro
                        },
                        child: const Text('Regístrate'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return InkWell( //Inkwell para que el botón sea interactivo
      onTap: onPressed,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Icon(
          icon,
          color: color,
          size: 30,
        ),
      ),
    );
  }
}