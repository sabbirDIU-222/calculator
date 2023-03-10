import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String equation = '0';
  String result = '0';
  String _expression = '0';
  double equation_font_size = 38.0;
  double result_font_size = 48.0;

  void onbuttonPressed(String selectednumber) {
    setState(() {
      if (selectednumber == 'C') {
        equation = '0';
        result = '0';
        double equation_font_size = 38.0;
        double result_font_size = 48.0;
      } else if (selectednumber == '⌫') {
        double equation_font_size = 38.0;
        double result_font_size = 48.0;

        equation = equation.substring(0, equation.length - 1);
        if (equation == '') {
          equation = '0';
        }
      } else if (selectednumber == '=') {
        double equation_font_size = 38.0;
        double result_font_size = 48.0;

        _expression = equation;
        _expression = _expression.replaceAll('×', '*');
        _expression = _expression.replaceAll('÷', '/');

        try {
          Parser p = new Parser();
          Expression exp = p.parse(_expression);
          ContextModel ctxM = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, ctxM)}';
        } catch (e) {
          result = 'ERROR';
        }
      } else {
        double equation_font_size = 38.0;
        double result_font_size = 48.0;

        if (equation == '0') {
          equation = selectednumber;
        } else {
          equation += selectednumber;
        }
      }
    });
  }

  Widget buildButton(String btnName, double btnheight, Color btncolor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * btnheight,
      color: btncolor,
      child: TextButton(
        child: Text(
          btnName,
          style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.normal,
              color: Colors.white),
        ),
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
                side: BorderSide(
                    style: BorderStyle.solid,
                    width: 1.0,
                    color: Colors.white))),
        onPressed: () => onbuttonPressed(btnName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('G-Calculator'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // showing the equation
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equation_font_size),
            ),
          ),
          // showing the result
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: result_font_size),
            ),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton('÷', 1, Colors.blue),
                        buildButton('×', 1, Colors.blue),
                        buildButton('-', 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('7', 1, Colors.black54),
                        buildButton('8', 1, Colors.black54),
                        buildButton('9', 1, Colors.black54),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('6', 1, Colors.black54),
                        buildButton('5', 1, Colors.black54),
                        buildButton('4', 1, Colors.black54),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('3', 1, Colors.black54),
                        buildButton('2', 1, Colors.black54),
                        buildButton('1', 1, Colors.black54),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('.', 1, Colors.black54),
                        buildButton('0', 1, Colors.black54),
                        buildButton('00', 1, Colors.black54),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [buildButton('+', 1, Colors.blue)]),
                    TableRow(
                        children: [buildButton('C', 1, Colors.deepPurple)]),
                    TableRow(children: [buildButton('⌫', 1, Colors.purple)]),
                    TableRow(
                        children: [buildButton('=', 2, Colors.deepPurple)]),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
