import 'package:flutter/foundation.dart';

class MaleModel with ChangeNotifier {
  bool ismale = false;

  void toggleMale() {
    ismale = !ismale;
    notifyListeners();
  }
}
