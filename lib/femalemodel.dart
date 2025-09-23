import 'package:flutter/foundation.dart';

class FemaleModel with ChangeNotifier {
  bool isfemale = false;

  void toggleFemale() {
    isfemale = !isfemale;
    notifyListeners();
  }
}
