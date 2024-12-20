import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _currentInput = "";
  String _operand = "";
  double _num1 = 0;
  double _num2 = 0;

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _currentInput = "";
        _operand = "";
        _num1 = 0;
        _num2 = 0;
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "×" ||
          buttonText == "÷") {
        _num1 = double.tryParse(_currentInput) ?? 0;
        _operand = buttonText;
        _currentInput = "";
      } else if (buttonText == "=") {
        _num2 = double.tryParse(_currentInput) ?? 0;

        switch (_operand) {
          case "+":
            _output = (_num1 + _num2).toString();
            break;
          case "-":
            _output = (_num1 - _num2).toString();
            break;
          case "×":
            _output = (_num1 * _num2).toString();
            break;
          case "÷":
            if (_num2 != 0) {
              _output = (_num1 / _num2).toStringAsFixed(2);
            } else {
              _output = "Error";
            }
            break;
        }
        _operand = "";
        _currentInput = _output;
      } else {
        _currentInput += buttonText;
        _output = _currentInput;
      }
    });
  }

  Widget _buildButton(String buttonText, Color color) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(20),
          backgroundColor: color,
        ),
        onPressed: () => _buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calculator")),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                _output,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Divider(),
          Column(
            children: [
              Row(
                children: [
                  _buildButton("7", Colors.blue),
                  _buildButton("8", Colors.blue),
                  _buildButton("9", Colors.blue),
                  _buildButton("÷", Colors.orange),
                ],
              ),
              Row(
                children: [
                  _buildButton("4", Colors.blue),
                  _buildButton("5", Colors.blue),
                  _buildButton("6", Colors.blue),
                  _buildButton("×", Colors.orange),
                ],
              ),
              Row(
                children: [
                  _buildButton("1", Colors.blue),
                  _buildButton("2", Colors.blue),
                  _buildButton("3", Colors.blue),
                  _buildButton("-", Colors.orange),
                ],
              ),
              Row(
                children: [
                  _buildButton("C", Colors.red),
                  _buildButton("0", Colors.blue),
                  _buildButton("=", Colors.green),
                  _buildButton("+", Colors.orange),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
