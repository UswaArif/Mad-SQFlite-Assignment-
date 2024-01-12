import 'package:crudoperations/pages/add_user_page.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
//import 'package:sqflite_common_ffi_web/sqflite_web.dart';

void main() {
  if(Platform.isWindows || Platform.isLinux)
  {
      // Initialize sqflite_common_ffi
    sqfliteFfiInit();

    // Initialize the database factory for sqflite_common_ffi
    databaseFactory = databaseFactoryFfi;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Create a custom MaterialColor for deepPurple
  static const MaterialColor customDeepPurple = MaterialColor(
    0xFF311B92, // Primary color value
    <int, Color>{
      50: Color(0xFFEDE7F6),
      100: Color(0xFFD1C4E9),
      200: Color(0xFFB39DDB),
      300: Color(0xFF9575CD),
      400: Color(0xFF7E57C2),
      500: Color(0xFF673AB7), // Primary color
      600: Color(0xFF5E35B1),
      700: Color(0xFF512DA8),
      800: Color(0xFF4527A0),
      900: Color(0xFF311B92),
    },
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aeroplane System',
      theme: ThemeData(),
      darkTheme: ThemeData(brightness: Brightness.light, primarySwatch: customDeepPurple),
      themeMode: ThemeMode.system,
      home: const SignUp(),
    );
  }
}

