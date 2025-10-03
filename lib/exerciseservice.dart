import 'dart:convert';

import 'package:fitbody/exercisemodel.dart';
import 'package:http/http.dart' as http;

Future<List<ExcerciseModel>> fetchExercises() async {
  const token = 'e95bee3138mshd37427bb8749536p1c84e0jsnbe60b29fd03d';

  final response = await http.get(
    Uri.parse('https://exercisedb-api1.p.rapidapi.com/api/v1/exercisetypes'),
    headers: {
      'X-RapidAPI-Key': token,
      'X-RapidAPI-Host': 'exercisedb-api1.p.rapidapi.com',
    },
  );

  if (response.statusCode == 200) {
    final decoded = jsonDecode(response.body);

    final List<dynamic> jsonList = decoded['data'];

    return jsonList.map((json) => ExcerciseModel.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load Exercises');
  }
}

Future<List<ExcerciseModel>> fetchEquipments() async {
  const token = 'e95bee3138mshd37427bb8749536p1c84e0jsnbe60b29fd03d';

  final response = await http.get(
    Uri.parse('https://exercisedb-api1.p.rapidapi.com/api/v1/exercisetypes'),
    headers: {
      'X-RapidAPI-Key': token,
      'X-RapidAPI-Host': 'exercisedb-api1.p.rapidapi.com',
    },
  );

  if (response.statusCode == 200) {
    final decoded = jsonDecode(response.body);

    final List<dynamic> jsonList = decoded['data'];

    return jsonList.map((json) => ExcerciseModel.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load Exercises');
  }
}
