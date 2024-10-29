import 'package:flutter/material.dart';

class ScanProvider2 with ChangeNotifier {
  String _inputType = "Input IMEI"; // Default value

  String get inputType => _inputType;

  void setInputType(String type) {
    _inputType = type;
    notifyListeners(); // This is crucial
  }
}
