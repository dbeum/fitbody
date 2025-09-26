import 'package:firebase_core/firebase_core.dart';
import 'package:fitbody/home.dart';
import 'package:fitbody/nav.dart';
import 'package:fitbody/provider/amodel.dart';
import 'package:fitbody/provider/bModel.dart';
import 'package:fitbody/setup/bio.dart';
import 'package:fitbody/provider/femalemodel.dart';
import 'package:fitbody/provider/imodel.dart';
import 'package:fitbody/provider/kgmodel.dart';
import 'package:fitbody/provider/lbsmodel.dart';
import 'package:fitbody/provider/malemodel.dart';
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
        ChangeNotifierProvider(create: (_) => MaleModel()),
        ChangeNotifierProvider(create: (_) => FemaleModel()),
        ChangeNotifierProvider(create: (_) => KgModel()),
        ChangeNotifierProvider(create: (_) => LbsModel()),
        ChangeNotifierProvider(create: (_) => Bmodel()),
        ChangeNotifierProvider(create: (_) => Imodel()),
        ChangeNotifierProvider(create: (_) => Amodel()),
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
      home: Nav(),
      debugShowCheckedModeBanner: false,
    );
  }
}
