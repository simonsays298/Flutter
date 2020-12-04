import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Homepage(title: 'Basic Phrases'),
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
  AudioPlayer advancedPlayer = AudioPlayer();
  String localFilePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.topLeft,
                colors: <Color>[
                  Colors.blue[50],
                  Colors.blue[100],
                  Colors.blue[200],
                  Colors.blue[300],
                  Colors.blue[400],
                  Colors.blue[500],
                ],
              ),
            ),
            child: const Center(
              child: Text(
                'Foreground Text',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
          );
        },
      ),
      // body:GridView.count(
      //   scrollDirection: Axis.vertical,
      //   crossAxisCount: 2,
      //   // ignore: always_specify_types
      //   shrinkWrap: true,
      //   primary: true,
      //   // ignore: always_specify_types
      //   children: List.generate(10, (int index) {
      //     return Container(
      //       margin: EdgeInsets.all(10) ,
      //       alignment: Alignment.bottomCenter,
      //       decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(20.0),
      //         gradient: LinearGradient(
      //           begin: Alignment.topRight,
      //           end: Alignment.topLeft,
      //           colors: <Color>[
      //             Colors.blue[50],
      //             Colors.blue[100],
      //             Colors.blue[200],
      //             Colors.blue[300],
      //             Colors.blue[400],
      //             Colors.blue[500],
      //
      //           ],
      //         ),
      //       ),
      //       child: Center(
      //         child: Text(
      //           "Foreground Text",
      //           style: TextStyle(color: Colors.white, fontSize: 20.0),
      //         ),
      //       ),
      //     );
      //   }),
      // ),

      // Expanded(

      //   ),
    );
  }
}
