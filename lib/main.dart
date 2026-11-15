import 'package:flutter/material.dart';
import 'package:gestionnary_task/pages/formulaire.dart';
import 'package:gestionnary_task/pages/login.dart';
import 'package:gestionnary_task/pages/register.dart';
// import 'package:material_ui/material_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/home.dart';
import 'pages/list_task.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
          brightness: Brightness.light,
        ),
        textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: GoogleFonts.oswald(
            fontSize: 30,
            fontStyle: FontStyle.italic,
          ),
          bodyMedium: GoogleFonts.merriweather(),
          displaySmall: GoogleFonts.pacifico(),
        ),
      ),

      initialRoute: '/login',
      routes: {
        '/login' : (context) => const Login(),
        '/register' : (context) => const Register(),
        '/home' :(context) => const MyHomePage(),
        '/list' : (context) => ListTask(),
        '/test' : (context) => MyCustomForm(),
      },
    );
  }
}