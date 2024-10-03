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
  // Define the state variables to store the values and operands
  String displayText = '0';
  double num1 = 0;
  double num2 = 0;
  String operand = '';
  bool isSecondOperand = false;

  // Define the buttonPressed function for handling all button clicks
  void buttonPressed(String buttonText) {
    setState(() {
      // Reset the calculator if 'C' button is pressed
      if (buttonText == 'C') {
        displayText = '0';
        num1 = 0;
        num2 = 0;
        operand = '';
        isSecondOperand = false;
      }
      // Perform the calculation if '=' button is pressed
      else if (buttonText == '=') {
        num2 = double.parse(displayText);
        switch (operand) {
          case '+':
            displayText = (num1 + num2).toString();
            break;
          case '-':
            displayText = (num1 - num2).toString();
            break;
          case '*':
            displayText = (num1 * num2).toString();
            break;
          case '/':
            displayText = num2 == 0 ? 'Error' : (num1 / num2).toString();
            break;
          default:
            break;
        }
        operand = '';
        isSecondOperand = false;
      }
      // Store the first operand and the operator when an operator button is pressed
      else if (buttonText == '+' || buttonText == '-' || buttonText == '*' || buttonText == '/') {
        num1 = double.parse(displayText);
        operand = buttonText;
        isSecondOperand = true;
        displayText = '0';
      }
      // Prevent multiple decimals in a single number
      else if (buttonText == '.') {
        if (!displayText.contains('.')) {
          displayText += buttonText;
        }
      }
      // Handle number button inputs
      else {
        if (isSecondOperand) {
          displayText = buttonText;
          isSecondOperand = false;
        } else {
          displayText = displayText == '0' ? buttonText : displayText + buttonText;
        }
      }
    });
  }

  // Define a widget to create calculator buttons
  Widget buildButton(String buttonText) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => buttonPressed(buttonText),
          child: Text(buttonText, style: TextStyle(fontSize: 20.0)),
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
          // Divider for display and button area
          Expanded(child: Divider()),
          // Number and operator buttons arranged in rows
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
