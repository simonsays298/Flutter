import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart'; // This is needed for AudioPlayer.

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
  String localFilePath;
  AudioCache audioCache = AudioCache();

  List<String> audio = <String>[
    'Cute',
    'Kawaii',
    'Hello',
    'Konnichiwa',
    'Goodbye',
    'Sayounara',
    'Interesting',
    'Omoshiroi',
    'Really',
    'Hontouni'
  ];
  List<String> translate = <String>[
    '',
    'かわいい',
    '',
    'こんにちは',
    '',
    'さようなら',
    '',
    'おもしろい',
    '',
    'ほんとうに'
  ];

  // static AudioPlayer audioPlayer = AudioPlayer(); // This is needed for AudioPlayer.
  // static String vTitle = 'My Audio app';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: GridView.builder(
        shrinkWrap: true,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                audioCache.play(audio[index] + '.mp3');
              });
            },
            child: Stack(
              children: <Widget>[
                Container(
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
                ),
                // Text(audioMap[index~/2].keys.first),
                Center(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Text(
                          audio[index],
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        translate[index],
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
