import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AudioPlayer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Audio Player'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AudioPlayer advancedPlayer;

  @override
  initState() {
    super.initState();
    loadMusic();
  }

  Future loadMusic() async {
    advancedPlayer = await AudioCache().loop("music/song3.mp3");
  }

  @override
  void dispose() {
    advancedPlayer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Audioplayers Example'),
        ),
        body: Container(),
      ),
    );
  }

// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: Text(widget.title),
//     ),
//     body: Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Container(
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     RaisedButton(
//                       onPressed: () {
//                         if (_isPlaying == true) {
//                           pauseAudio();
//                           setState(() {
//                             _isPlaying = false;
//                           });
//                         } else {
//                           resumeAudio();
//                           setState(() {
//                             _isPlaying = true;
//                           });
//                         }
//                       },
//                       child:
//                       Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
//                       color: Colors.blue,
//                     ),
//                     RaisedButton(
//                       onPressed: () {
//                         stopAudio();
//                         setState(() {
//                           _isPlaying = false;
//                         });
//                       },
//                       child: Icon(Icons.stop),
//                       color: Colors.blue,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               RaisedButton(
//                 onPressed: () async {
//                   String path ='translate_tts.mp3';
//                   setState(() {
//                     _isPlaying = true;
//                   });
//                   playAudioFromLocalStorage(path);
//                 },
//                 child: Text(
//                   'Load Audio File',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 color: Colors.blueAccent,
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }
}
