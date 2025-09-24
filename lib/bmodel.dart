import 'package:flutter/material.dart';

class Bmodel with ChangeNotifier {
  bool bmodel = false;

  void togglebmode() {
    bmodel = !bmodel;
    notifyListeners();
  }
}
