import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:powers/powers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Homepage(title: 'Number Shapes'),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final String _msg =
      'Please input a number to see if it is SQUARE or TRIANGULAR';
  String _value = '';
  final String _cube = 'is TRIANGLE';
  final String _square = 'is SQUARE';
  final String _both = 'is both SQUARE and TRIANGULAR';
  final String _neither = 'is neither SQUARE nor TRIANGULAR';
  String _res = '';
  String error = '';
  bool show = true;
  double number;
  String inputString = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.network(
                'https://image.freepik.com/free-vector/flat-thinking-concept_23-2148163823.jpg',
                height: 200.0,
                width: 200.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _msg,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            TextField(
              onChanged: (String value) {
                _value = value;
              },
              keyboardType: TextInputType.number,
              // ignore: always_specify_types
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'\d+([\.]\d+)?')),
              ],
              decoration: InputDecoration(
                errorText: error,
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Column(
              // ignore: always_specify_types
              children: [
                RaisedButton(
                  color: Colors.lightGreen,
                  shape: const CircleBorder(),
                  splashColor: Colors.greenAccent,
                  animationDuration: const Duration(seconds: 12),
                  colorBrightness: Brightness.light,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <Widget>[
                        const Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      number = double.tryParse(_value) ?? 0;
                      if (number != 0) {
                        show = true;
                        error = '';
                        checkSqrOrCube(number);
                      } else {
                        error = 'Enter a valid number';
                        show = false;
                      }
                      if (show == true) {
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Color.fromRGBO(204, 255, 255, 0.8),
                              title: Text(
                                _value,
                                textAlign: TextAlign.center,
                              ),
                              content: SingleChildScrollView(
                                child: Text(_res,
                                  textAlign: TextAlign.center,),
                              ),
                            );
                          },
                        );
                      }
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void checkSqrOrCube(double number) {
    if (number.isSquare && number.isCube) {
      _res = 'Number ' + _value + ' ' + _both;
    } else {
      if (number.isSquare) {
        _res = 'Number ' + _value + ' ' + _square;
      } else {
        if (number.isCube) {
          _res = 'Number ' + _value + ' ' + _cube;
        } else {
          _res = 'Number ' + _value + ' ' + _neither;
        }
      }
    }
  }
}
