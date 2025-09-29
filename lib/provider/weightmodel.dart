import 'package:flutter/material.dart';

class WeightModel with ChangeNotifier {
  bool kgmodel = false;
  bool lbsModel = false;

  void toggleLbs() {
    lbsModel = !lbsModel;
    notifyListeners();
  }

  void toggleKg() {
    kgmodel = !kgmodel;
    notifyListeners();
  }
}
