import 'package:flutter/material.dart';

class StarModel with ChangeNotifier {
  bool isStar = false;
  bool isStar2 = false;
  bool isStar3 = false;
  bool isStar4 = false;

  void toggleStar() {
    isStar = !isStar;

    notifyListeners();
  }

  void toggleStar2() {
    isStar2 = !isStar2;

    notifyListeners();
  }

  void toggleStar3() {
    isStar3 = !isStar3;

    notifyListeners();
  }

  void toggleStar4() {
    isStar4 = !isStar4;
    notifyListeners();
  }
}
