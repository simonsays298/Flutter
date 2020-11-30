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
              padding: const EdgeInsets.all(12.0),
              child: Text(_msg2),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Visibility(
                child: Text(
                  'You tried ' + _value + '\n' + _msg3,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20),
                ),
                visible: show,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Card(
                child: Column(
                  children: <Widget>[
                    const Text('Try a number !!!'),
                    TextField(
                      keyboardType: TextInputType.number,
                      // decoration: InputDecoration(
                      //   errorText: error,
                      // ),
                      // ignore: always_specify_types
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'\d+([\.]\d+)?')),
                      ],
                      controller: myController,
                      onChanged: (String value) {
                        _value = value;
                        // print(number);
                      },
                    ),
                    RaisedButton(
                        child: Text(guess),
                        textColor: Colors.blue,
                        onPressed: () {
                          setState(() {
                            if (guess == 'Reset') {
                              show = false;
                              guess = 'Guess';
                              _value = '';
                              myController.clear();
                              number = Random().nextInt(100);

                            } else {
                              _givenNumber = int.tryParse(_value) ?? 0;
                              if (_givenNumber == 0) {
                                // error = 'insert a proper number';
                                show = false;
                              } else {
                                // error = '';
                                // print(_givenNumber);
                                if (_givenNumber == number) {
                                  // print('A');
                                  show = true;
                                  _msg3 = 'You guessed right';
                                  showDialog<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('You guessed right!'),
                                        content: SingleChildScrollView(
                                          child: Text('$_givenNumber'),
                                        ),
                                        actions: <Widget>[
                                          Row(
                                            // ignore: always_specify_types
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    guess = 'Guess';
                                                    show = false;
                                                    myController.clear();
                                                    _value = '';
                                                    number =
                                                        Random().nextInt(100);
                                                    // print(number);
                                                  });

                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Try again!'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    guess = 'Reset';
                                                  });

                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          )
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  if (_givenNumber < number) {
                                    // print('B');
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

  void tryAgain() {}

  void pressOk() {
    // guess = 'Reset';
    // show = false;
  }
}
