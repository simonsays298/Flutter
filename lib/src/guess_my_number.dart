import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homepage(title: 'Guess My Number'),
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
  String _msg = 'I\'m thinking of a number betweeen 1 and 100';
  String _msg2 = 'It\'s your turn to guess my number';
  String _res = '';
  String guess ='Guess';
  int number = new Random().nextInt(100);
  String error = '';
  bool show = true;


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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(_msg),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(_msg2),
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Card(
                child: Column(
                  children: <Widget>[
                    Text("Try a number !!!"),
                    TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r"\d+([\.]\d+)?")),
                      ],
                      onChanged: (String value) {
                        _res = value;

                        print(number);
                      },
                    ),
                    RaisedButton(
                        child: Text(guess),
                        textColor: Colors.blue,
                        onPressed: () {
                          if (int.parse(_res) == number) {
                            showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("You guessed right!"),
                                  content: SingleChildScrollView(
                                    child: Text(_res),
                                  ),
                                  actions: <Widget>[
                                    Row(
                                      children: [
                                        TextButton(
                                          onPressed: () {

                                            Navigator.of(context).pop();

                                          },
                                          child: Text("Try again!"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();

                                          },

                                          child: Text("OK"),
                                        ),
                                      ],
                                    )
                                  ],
                                );
                              },
                            );
                          } else {
                            if (int.parse(_res) < number) {
                              print("Higher");
                            } else {
                              print("Lower");
                            }
                          }
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
}
