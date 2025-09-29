import 'package:flutter/material.dart';

class Activitymodel with ChangeNotifier {
  bool bmodel = false;
  bool imodel = false;
  bool amodel = false;

  void toggleimode() {
    imodel = !imodel;
    notifyListeners();
  }

  void togglebmode() {
    bmodel = !bmodel;
    notifyListeners();
  }

  void toggleamode() {
    amodel = !amodel;
    notifyListeners();
  }
}
