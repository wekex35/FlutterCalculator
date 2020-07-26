import 'package:calculator/utils/app_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class MainProvider extends ChangeNotifier {
  String _currentText = "";
  bool _wasSymbol = false;
  double _total = 0;
  var _themeMode = ThemeMode.light;
  List<String> _calHistory = new List();

  bool get wasSymbol => _wasSymbol;
  String get getCurrentText => _currentText;
  List<String> get calHistory => _calHistory;

  String get getTotal => _total.toStringAsFixed(2);

  get themeMode => _themeMode;
  void setThemeMode(value){
    if(value){
      _themeMode = ThemeMode.dark ;
    }else{
      _themeMode = ThemeMode.light ;
    }
    notifyListeners();
  }
  void setCurrent(value) {
    bool update = false;
    switch (value) {
      case "=":
        if(_currentText.length > 0){
        _calHistory.add(_currentText + "=" + calcString(_currentText).toStringAsFixed(2));
        _calHistory = _calHistory.reversed.toList();
        _currentText = calcString(_currentText).toStringAsFixed(2);
        }
        break;
      case "AC":
        _currentText = "";
        //  _total = 0;
        break;
       case ".":
        if (!_currentText.contains(".")) {
            _currentText += value;
          }
        //  _total = 0;
        break;

      case "←":
        if (_currentText.length > 0)
          _currentText = _currentText.substring(0, _currentText.length - 1);
        break;
      default:        
          _currentText += value;
        update = true;
        break;
    }

    if (isCharSymbol(value) && update) {
      if(_currentText.length == 1){
          _currentText = _currentText.substring(0, _currentText.length - 1);
        }if (wasSymbol && _currentText.length > 1) {
        print("object");
        _currentText = _currentText.substring(0, _currentText.length - 2);
        _currentText += value;
      }
      _wasSymbol = true;
    } else {
      _wasSymbol = false;
      if (_currentText.length > 0) _total = calcString(_currentText);
    }

    notifyListeners();
  }

  void clearHistory() {
    calHistory.clear();
    _total = 0;
    _currentText = "";
    notifyListeners();
  }
}
