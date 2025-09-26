import 'package:flutter/material.dart';

class Imodel with ChangeNotifier {
  bool imodel = false;

  void toggleimode() {
    imodel = !imodel;
    notifyListeners();
  }
}
