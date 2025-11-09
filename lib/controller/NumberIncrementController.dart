import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class NumberIncreaseController extends GetxController {
  int number = 0;

  increaseNumber() {
    number++;
    update();
  }
}

class CalculatorEngine extends GetxController {
  String _display = '';
  double? _num1;
  double? _num2;
  String? _operator;
  bool _shouldClear = false;

  String get display => _display;

  // Button press handler
  void btnPressed(String value) {
    if (value == 'C') {
      clear();
      update();
      return;
    }

    if (value == '=') {
      _evaluate();
      update();
      return;
    }

    if (value == 'UNDO') {
      undo();
      update();
      return;
    }

    if (_isOperator(value)) {
      if (_num1 == null) {
        _num1 = double.tryParse(_display);
      } else if (_operator != null && _display.isNotEmpty) {
        _num2 = double.tryParse(_display);
        _num1 = _compute(_num1!, _num2!, _operator!);
        _display = _num1!.toString();
      }
      _operator = value;
      _shouldClear = true;
      update();
      return;
    }

    // Digits or decimal
    if (_shouldClear) {
      _display = '';
      _shouldClear = false;
    }
    if (value == '.' && _display.contains('.')) return;

    _display += value;
    update();
  }

  bool _isOperator(String v) => ['+', '-', '*', '/', '%'].contains(v);

  double _compute(double a, double b, String op) {
    switch (op) {
      case '+':
        return a + b;
      case '-':
        return a - b;
      case '*':
        return a * b;
      case '/':
        if (b == 0) throw Exception("Cannot divide by zero");
        return a / b;
      case '%':
        return a % b;
      default:
        throw Exception("Invalid operator");
    }
  }

  void _evaluate() {
    if (_num1 != null && _operator != null && _display.isNotEmpty) {
      _num2 = double.tryParse(_display);
      if (_num2 != null) {
        _display = _compute(_num1!, _num2!, _operator!).toString();
        _num1 = double.tryParse(_display);
        _operator = null;
        _num2 = null;
        _shouldClear = true;
      }
    }
  }

  void undo() {
    if (_display.isNotEmpty) {
      _display = _display.substring(0, _display.length - 1);
    } else if (_operator != null) {
      // If display is empty but an operator exists, remove it
      _operator = null;
    }
  }

  void clear() {
    _display = '';
    _num1 = null;
    _num2 = null;
    _operator = null;
    _shouldClear = false;
  }
}
