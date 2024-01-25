import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
// imports the math equations
import 'calc_button.dart';


//made a class for how the calculator works
class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
  
}

class _CalculatorViewState extends State<CalculatorView> {
  // named all the variables and gave them values
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

//this makes decimals work
  buttonPressed(String buttonText) {
    // used to check if the result contains a decimal
String doesContainDecimal(dynamic result) {
  // the doesContainDecimal function checks to see if a dynamic result value 
  // has a decimal point and returns a different result if it doesnt have decimal places
      if (result.toString().contains('.')) {
        //this function checks if the integer value of the second substring is more than 0.
        // If it isn't, it means the decimal part of the number is zero or it is empty. if it is 0, it uses result = splitDecimal[0].toString() to remove the decimals.
        List<String> splitDecimal = result.toString().split('.');
        if (!(int.parse(splitDecimal[1]) > 0)) {
          return result = splitDecimal[0].toString();
        }
      }
      return result;
    }
// this is all the math
    setState(() {
      // it clears the numbers and sets it back to zero
      if (buttonText == "AC") {
        equation = "0";
        result = "0";
        //deletes the last character at a time. if there is nothing left it is set to zero
      } else if (buttonText == "⌫") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
        // turns the numbers into a negative, or to a positive. 
      } else if (buttonText == "+/-") {
        if (equation[0] != '-') {
          equation = '-$equation';
        } else {
          equation = equation.substring(1);
        }
      } else if (buttonText == "=") {
        //this gets the answer
        //Custom symbols such as '×' and '÷' are replaced with their 
        //corresponding mathematical operators (* and /) in the expression.
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('%', '%');

        try {
          //does a math expression, converts into numbers
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          if (expression.contains('%')) {
            result = doesContainDecimal(result);
          }
        } catch (e) {
          // if something goes wrong, it returns as an error
          result = "Error";
        }
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }
  @override
  
  Widget build(BuildContext context) {
    // all the decortation
    return  Scaffold(
        backgroundColor: Colors.black54,
        appBar: AppBar(
          elevation: 0, //applys a surface tint overlay to the background color 
          backgroundColor: Colors.black54,
          leading: const Icon(Icons.settings, color: Colors.orange),
          actions: const [
            Padding(
              padding: EdgeInsets.only(top: 18.0),
              child: Text('DEG', style: TextStyle(color: Colors.white38)),
            ),
            SizedBox(width: 20), // how it stays in a certain spot
          ],
        ),
        body:  SafeArea( //Creates a widget that avoids operating system interface
          child: Column(
             mainAxisAlignment: MainAxisAlignment.end,
             // ensures that the children within the Column are aligned to the bottom of the screen.
    children: [
      Align(
       
        alignment: Alignment.bottomRight,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(result,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              color: Colors.white, fontSize:80))),
                  const Icon(Icons.more_vert,
                      color: Colors.orange, size: 30),
                  const SizedBox(width: 20),
                ],
              ),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcButton('AC', Colors.white10, () => buttonPressed('AC')),
                  calcButton('', Colors.black, () => buttonPressed('')),
                  calcButton('÷', Colors.white10, () => buttonPressed('÷')),
                  calcButton("×", Colors.white10, () => buttonPressed('×')),
                ],
              ),
              const SizedBox(height: 10),

              Row(
                //buttons that allow users to input numbers and perform calculations
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcButton('7', Colors.white24, () => buttonPressed('7')),
                  calcButton('8', Colors.white24, () => buttonPressed('8')),
                  calcButton('9', Colors.white24, () => buttonPressed('9')),
                  calcButton('-', Colors.white10, () => buttonPressed('-')),
                ],
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcButton('4', Colors.white24, () => buttonPressed('4')),
                  calcButton('5', Colors.white24, () => buttonPressed('5')),
                  calcButton('6', Colors.white24, () => buttonPressed('6')),
                  calcButton('+', Colors.white10, () => buttonPressed('+')),
                ],
              ),
              const SizedBox(height: 10),
              // calculator number buttons

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround
                    children: [
                      Row(
                        children: [
                          calcButton(
                              '1', Colors.white24, () => buttonPressed('1')),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.001),
                          calcButton(
                              '2', Colors.white24, () => buttonPressed('2')),
                         SizedBox(
                              width: MediaQuery.of(context).size.width * 0.001),
                          calcButton(
                              '3', Colors.white24, () => buttonPressed('3')),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          calcButton('+/-', Colors.white24,
                              () => buttonPressed('+/-')),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.001),
                          calcButton(
                              '0', Colors.white24, () => buttonPressed('0')),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.001),
                          calcButton(
                              '.', Colors.white24, () => buttonPressed('.')),
                        ],
                      ),
                    ],
                  ),
                  calcButton('=', Colors.orange, () =>                         buttonPressed('=')),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(equation,
                        style: const TextStyle(
                          fontSize: 40,
                          color: Colors.white38,
                        )),
                  ),
                  IconButton(
                    icon: const Icon(Icons.backspace_outlined,
                        color: Colors.orange, size: 30),
                    onPressed: () {
                      buttonPressed("⌫");
                    },
                  ),
                   const SizedBox(width: 20),
                ],
              )
            ],
          ),
        ),
      ),
    ],
  )
          ),
          
        );
  }
}
  


