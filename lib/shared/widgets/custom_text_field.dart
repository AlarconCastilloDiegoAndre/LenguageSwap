import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget { //Clase que define un campo de texto personalizado
  final TextEditingController controller; //Controlador de texto y permite modificar el texto
  final String hintText; //Texto que se muestra cuando el campo está vacío
  final IconData prefixIcon; //Icono que se muestra antes del campo de texto
  final Widget? suffixIcon; //Icono que se muestra después del campo de texto
  final bool obscureText; //Variable que permite mostrar u ocultar el texto
  final TextInputType keyboardType; //Tipo de teclado que se muestra (numero, correo, etc.)
  final String? Function(String?)? validator; //Funcion que permite validar el texto

  const CustomTextField({ //Constructor de la clase
    super.key, //Clave que permite identificar el widget
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) { //Construimos el campo de texto
    return TextFormField( //Retorna un campo de texto con un decorador 
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText, 
        prefixIcon: Icon(prefixIcon, color: Colors.grey),
        suffixIcon: suffixIcon,
      ),
    );
  }
}