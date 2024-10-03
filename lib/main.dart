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
  // Variables to store the display value, operands, and operator
  String displayText = '0';
  double num1 = 0;
  double num2 = 0;
  String operand = '';
  bool isSecondOperand = false;

  // Function to handle button presses
  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        // Clear everything and reset
        displayText = '0';
        num1 = 0;
        num2 = 0;
        operand = '';
        isSecondOperand = false;
      } else if (buttonText == '=') {
        // Perform calculation and update display
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
        // Store the first operand and operator, and prepare for second operand
        num1 = double.parse(displayText);
        operand = buttonText;
        isSecondOperand = true;
        displayText = '0';
      } 
      // Handle decimal point input
      else if (buttonText == '.') {
        if (!displayText.contains('.')) {
          if (displayText == '0') {
            displayText = '0.';
          } else {
            displayText += buttonText;
          }
        }
      } 
      // Handle number input
      else {
        if (displayText == '0' || isSecondOperand) {
          displayText = buttonText;
          isSecondOperand = false;
        } else {
          displayText += buttonText;
        }
      }
    });
  }

  // Widget to create calculator buttons
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
          // Display area
          Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.all(16),
            child: Text(
              displayText,
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
          // Divider between display and buttons
          Expanded(child: Divider()),
          // Number and operator buttons in rows
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
