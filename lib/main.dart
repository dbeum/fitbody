import 'package:firebase_core/firebase_core.dart';
import 'package:fitbody/auth.dart';
import 'package:fitbody/home.dart';
import 'package:fitbody/login.dart';
import 'package:fitbody/nav.dart';
import 'package:fitbody/provider/activitymodel.dart';

import 'package:fitbody/provider/starmodel.dart';
import 'package:fitbody/setup/bio.dart';
import 'package:fitbody/provider/gendermodel.dart';
import 'package:fitbody/provider/weightmodel.dart';

import 'package:fitbody/register.dart';
import 'package:fitbody/setup/setup.dart';
import 'package:fitbody/setup/setupage.dart';
import 'package:fitbody/setup/setupheight.dart';
import 'package:fitbody/setup/setupactivity.dart';
import 'package:fitbody/welcome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GenderModel()),
        ChangeNotifierProvider(create: (_) => WeightModel()),

        ChangeNotifierProvider(create: (_) => StarModel()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dartby',
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        appBarTheme: AppBarTheme(color: Color.fromARGB(255, 35, 35, 35)),
        scaffoldBackgroundColor: Color.fromARGB(255, 35, 35, 35),
        primarySwatch: Colors.deepOrange,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.white),
        ),
        // Other theme settings...
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark, // Dark theme
        useMaterial3: true,
        // Define your dark theme here
        primarySwatch: Colors.deepOrange,
        appBarTheme: AppBarTheme(color: Color.fromARGB(255, 35, 35, 35)),
        scaffoldBackgroundColor: Color.fromARGB(255, 35, 35, 35),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.white),
        ),
      ),
      themeMode: ThemeMode.system,
      home: AuthCheck(),
      debugShowCheckedModeBanner: false,
    );
  }
}
