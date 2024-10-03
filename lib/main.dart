import 'package:flutter/material.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String displayText = '0';
  double num1 = 0;
  double num2 = 0;
  String operand = '';
  bool isSecondOperand = false;

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        // Reset all variables
        displayText = '0';
        num1 = 0;
        num2 = 0;
        operand = '';
        isSecondOperand = false;
      } else if (buttonText == '=') {
        // Perform the calculation when '=' is pressed
        num2 = double.parse(displayText);

        if (operand == '+') {
          displayText = (num1 + num2).toString();
        } else if (operand == '-') {
          displayText = (num1 - num2).toString();
        } else if (operand == '*') {
          displayText = (num1 * num2).toString();
        } else if (operand == '/') {
          displayText = num2 == 0 ? 'Error' : (num1 / num2).toString();
        }

        operand = '';
        isSecondOperand = false;
      } else if (buttonText == '+' || buttonText == '-' || buttonText == '*' || buttonText == '/') {
        // Store the first operand and operator
        num1 = double.parse(displayText);
        operand = buttonText;
        isSecondOperand = true;
        displayText = '0';
      } else if (buttonText == '.') {
        // Prevent multiple decimals in a single number
        if (!displayText.contains('.')) {
          displayText += buttonText;
        }
      } else {
        // Handle number inputs
        if (displayText == '0' || isSecondOperand) {
          displayText = buttonText;
          isSecondOperand = false;
        } else {
          displayText += buttonText;
        }
      }
    });
  }

  // Method to build buttons
  Widget buildButton(String buttonText) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator')),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.all(16),
            child: Text(
              displayText,
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Divider()),
          Column(
            children: [
              Row(
                children: <Widget>[
                  buildButton('7'), buildButton('8'), buildButton('9'), buildButton('/'),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton('4'), buildButton('5'), buildButton('6'), buildButton('*'),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton('1'), buildButton('2'), buildButton('3'), buildButton('-'),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton('.'), buildButton('0'), buildButton('00'), buildButton('+'),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton('C'), buildButton('='),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
