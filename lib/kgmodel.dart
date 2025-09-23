import 'package:flutter/material.dart';

class KgModel with ChangeNotifier {
  bool kgmodel = false;
  void toggleKg() {
    kgmodel = !kgmodel;
    notifyListeners();
  }
}
