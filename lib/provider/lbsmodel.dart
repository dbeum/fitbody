import 'package:flutter/material.dart';

class LbsModel with ChangeNotifier {
  bool lbsModel = false;
  void toggleLbs() {
    lbsModel = !lbsModel;
    notifyListeners();
  }
}
