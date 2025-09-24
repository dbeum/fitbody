import 'package:flutter/material.dart';

class Amodel with ChangeNotifier {
  bool amodel = false;

  void toggleamode() {
    amodel = !amodel;
    notifyListeners();
  }
}
