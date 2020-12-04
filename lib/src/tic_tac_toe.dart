import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Homepage(title: 'Tic-Tac-Toe'),
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
  final TextEditingController myController = TextEditingController();
  bool selected = true;
  List<int> player1 = <int>[];
  List<int> player2 = <int>[];
  int winner;
  List<int> winCol = <int>[];
  bool show = false;
  int count = 0;
  String _win = 'No winner';
  List<Color> colors = <Color>[
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          GridView.count(
            crossAxisCount: 3,
            // ignore: always_specify_types
            shrinkWrap: true,
            primary: true,
            // ignore: always_specify_types
            children: List.generate(9, (int index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    if (selected) {
                      colors[index] = Colors.red;
                      print(selected);
                      selected = !selected;
                      player1.add(index + 1);
                    } else {
                      colors[index] = Colors.green;
                      selected = !selected;
                      player2.add(index + 1);
                    }

                    if (count == 8) {
                      show = true;
                    }
                    if (checkWin() == 1 || checkWin() == 2) {
                      show = true;

                      _win = 'Winner is player ' + checkWin().toString();
                      for (int i = 0; i < 9; i++) {
                        if (!winCol.contains(i)) {
                          colors[i] = Colors.white;
                        }
                      }
                      winCol.clear();
                      // print(winCol);
                    }
                    count++;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 0.25),
                    color: colors[index],
                  ),
                  // child: Image.network("https://robohash.org/$index"),
                ),
              );
            }),
          ),
          Visibility(
            visible: show,
            child: RaisedButton(
                child: const Text('Play again!'),
                onPressed: () {
                  setState(() {
                    colors = <Color>[
                      Colors.white,
                      Colors.white,
                      Colors.white,
                      Colors.white,
                      Colors.white,
                      Colors.white,
                      Colors.white,
                      Colors.white,
                      Colors.white,
                    ];
                    winner = 0;
                    count = 0;
                    _win = 'No winner';
                    player1.clear();
                    player2.clear();
                    show = false;
                  });
                }),
          ),
          Visibility(
            visible: show,
            child: Text(_win),
          ),
        ],
      ),
    );
  }

  int checkWin() {
    print(player1);
    if (player1.contains(1) && player1.contains(2) && player1.contains(3)) {
      winner = 1;
      winCol.add(0);
      winCol.add(1);
      winCol.add(2);
    }
    if (player2.contains(1) && player2.contains(2) && player2.contains(3)) {
      winner = 2;
      winCol.add(0);
      winCol.add(1);
      winCol.add(2);
    }

    // row 2
    if (player1.contains(4) && player1.contains(5) && player1.contains(6)) {
      winner = 1;
      winCol.add(3);
      winCol.add(4);
      winCol.add(5);
    }
    if (player2.contains(4) && player2.contains(5) && player2.contains(6)) {
      winner = 2;
      winCol.add(3);
      winCol.add(4);
      winCol.add(5);
    }

    // row 3
    if (player1.contains(7) && player1.contains(8) && player1.contains(9)) {
      winner = 1;
      winCol.add(6);
      winCol.add(7);
      winCol.add(8);
    }
    if (player2.contains(7) && player2.contains(8) && player2.contains(9)) {
      winner = 2;
      winCol.add(6);
      winCol.add(7);
      winCol.add(8);
    }

    // col 1
    if (player1.contains(1) && player1.contains(4) && player1.contains(7)) {
      winner = 1;
      winCol.add(0);
      winCol.add(3);
      winCol.add(6);
    }
    if (player2.contains(1) && player2.contains(4) && player2.contains(7)) {
      winner = 2;
      winCol.add(0);
      winCol.add(3);
      winCol.add(6);
    }

    // col 2
    if (player1.contains(2) && player1.contains(5) && player1.contains(8)) {
      winner = 1;
      winCol.add(1);
      winCol.add(4);
      winCol.add(7);
    }
    if (player2.contains(2) && player2.contains(5) && player2.contains(8)) {
      winner = 2;
      winCol.add(1);
      winCol.add(4);
      winCol.add(7);
    }

    // col 3
    if (player1.contains(3) && player1.contains(6) && player1.contains(9)) {
      winner = 1;
      winCol.add(2);
      winCol.add(5);
      winCol.add(8);
    }
    if (player2.contains(3) && player2.contains(6) && player2.contains(9)) {
      winner = 2;
      winCol.add(2);
      winCol.add(5);
      winCol.add(8);
    }
    return winner;
  }
}
