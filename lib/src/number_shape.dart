
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:powers/powers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homepage(title: 'Number Shapes'),
    );
  }
}

class Homepage extends StatefulWidget {
  Homepage({Key key, this.title}) : super(key: key);
  @override
  final String title;

  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  String _msg = 'Please input a number to see if it is square or triangle';
  String _value = '';
  String _cube = 'is TRIANGLE';
  String _square = 'is SQUARE';
  String _both = 'is both SQUARE and TRINAGLUAR';
  String _neither = 'is neither SQUARE or TRINAGLUAR';
  String _res = '';
  String error = '';
  bool show = true;
  double number;
  String inputString = "";

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Text(
              _msg,
            ),
            TextField(
              onChanged: (String value) {
                _value = value;
                number = double.tryParse(_value) ?? double.maxFinite;
              },
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r"\d+([\.]\d+)?")),
              ],
              decoration: InputDecoration(
                errorText: error,
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Column(
              children: [
                RaisedButton(
                  color: Colors.lightGreen,
                  shape: CircleBorder(),
                  splashColor: Colors.greenAccent,
                  animationDuration: Duration(seconds: 8),
                  colorBrightness: Brightness.light,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      if (number != double.maxFinite) {
                        show = true;
                        error = '';
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
                      } else {
                        error = "Enter a valid number";
                        show = false;
                      }
                      if (show == true) {
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(_value),
                              content: SingleChildScrollView(
                                child: Text(_res),
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
}
