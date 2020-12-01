import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Homepage(title: 'Guess My Number'),
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
  final String _msg = 'I\'m thinking of a number between 1 and 100';
  final String _msg2 = 'It\'s your turn to guess my number';
  String _msg3 = '';
  String _value = '';
  int _givenNumber;
  String guess = 'Guess';
  int number = Random().nextInt(100);
  bool congrats = false;
  String error = '';
  bool show = false;
  final TextEditingController myController = TextEditingController();

  String inputString = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(_msg),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(_msg2),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Visibility(
                child: Text(
                  'You tried ' + _value + '\n' + _msg3,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                visible: show,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Visibility(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Image.network(
                    'https://image.freepik.com/free-vector/congrats-greeting-card_53876-82116.jpg',
                    height: 100.0,
                    width: 100.0,
                  ),
                ),
                visible: congrats,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                child: Column(
                  children: <Widget>[
                    const Text('Try a number !!!',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                    TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'\d+([\.]\d+)?')),
                      ],
                      controller: myController,
                      onChanged: (String value) {
                        _value = value;
                      },
                    ),
                    RaisedButton(
                        child: Text(guess),
                        textColor: Colors.blue,
                        splashColor: Color.fromRGBO(240,255,255, 1.0),
                        onPressed: () {
                          setState(() {
                            if (guess == 'Reset') {
                              reset();
                            } else {
                              _givenNumber = int.tryParse(_value) ?? 0;
                              if (_givenNumber == 0) {
                                show = false;
                                congrats = false;
                              } else {
                                if (_givenNumber == number) {
                                  congrats = true;
                                  show = true;
                                  _msg3 = 'You guessed right';
                                  showDialog<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0))),
                                        backgroundColor:
                                            Color.fromRGBO(240,255,255, 0.8),
                                        title: const Text(
                                          'You guessed right!',
                                          textAlign: TextAlign.center,
                                        ),
                                        content: SingleChildScrollView(
                                          child: Text(
                                            'The number was $_givenNumber',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        actions: <Widget>[
                                          Row(
                                            // ignore: always_specify_types
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    tryAgain();
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text(
                                                  'Try again!',
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    guess = 'Reset';
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text(
                                                  'OK',
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  if (_givenNumber < number) {
                                    _msg3 = 'Try higher!';
                                    show = true;
                                  } else {
                                    _msg3 = 'Try lower';
                                    show = true;
                                  }
                                }
                              }
                            }
                          });
                        }),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }

  void tryAgain() {
    guess = 'Guess';
    show = false;
    congrats = false;
    myController.clear();
    _value = '';
    number = Random().nextInt(100);
  }

  void reset() {
    show = false;
    congrats = false;
    guess = 'Guess';
    _value = '';
    myController.clear();
    number = Random().nextInt(100);
  }
}
