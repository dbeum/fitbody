import 'package:flutter/foundation.dart';

class GenderModel with ChangeNotifier {
  bool isfemale = false;
  bool ismale = false;

  void toggleFemale() {
    isfemale = !isfemale;
    notifyListeners();
  }

  void toggleMale() {
    ismale = !ismale;
    notifyListeners();
  }
}
