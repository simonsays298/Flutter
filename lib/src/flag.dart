import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:filter_list/filter_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Homepage(title: 'Movies'),
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
  final TextEditingController controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  LinkedHashSet<List<String>> set3 = LinkedHashSet<List<String>>();
  Map<String, dynamic> map = <String, dynamic>{};
  List<List<String>> movies = <List<String>>[];
  List<String> resList = <String>['all'];

  int pageNumber = 1;
  bool newPage = false;

  List<String> genreList = <String>[
    'all',
    'Action',
    'Adventure',
    'Animation',
    'Biography',
    'Comedy',
    'Crime',
    'Documentary',
    'Drama',
    'Family',
    'Fantasy',
    'History',
    'Horror',
    'Musical',
    'Mystery',
    'Thriller',
    'Reality-Tv',
    'Romance',
    'Sci-Fi',
    'War',
    'Western',
  ];

  Future<void> getMovies(List<String> list) async {
    if (newPage == false) {
      movies.clear();
      set3.clear();
    }

    for (int i = 0; i < list.length; i++) {
      final Response resp = await get('https://yts.mx/api/v2/list_movies.json?genre=' + list[i] + '&page=$pageNumber');

      setState(
        () {
          map = jsonDecode(resp.body);
          final List<dynamic> genreList = map['data']['movies'];
          for (int j = 0; j < genreList.length; j++) {
            final List<String> m = <String>[];
            m.add(map['data']['movies'][j]['title']);
            m.add(map['data']['movies'][j]['medium_cover_image']);
            m.add(map['data']['movies'][j]['year'].toString());
            m.add(map['data']['movies'][j]['rating'].toString());
            m.add(list[i]);
            set3.add(m);
          }
          movies = set3.toList();
        },
      );
    }
    pageNumber++;
  }

  @override
  void initState() {
    getMovies(<String>['all']);
    setState(
      () {
        _scrollController.addListener(
          () {
            if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
              newPage = true;
              getMovies(resList);
            }
          },
        );
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _openFilterDialog() async {
    await FilterListDialog.display(
      context,
      allResetButonColor: const Color.fromRGBO(102, 0, 51, 0.8),
      applyButonTextBackgroundColor: const Color.fromRGBO(102, 0, 51, 0.8),
      selectedTextBackgroundColor: const Color.fromRGBO(102, 0, 51, 0.8),
      allTextList: genreList,
      height: 480,
      hidecloseIcon: true,
      borderRadius: 20,
      headlineText: 'Choose your genre',
      searchFieldHintText: 'Search Here',
      onApplyButtonClick: (List<String> list) {
        resList = list;
        pageNumber = 1;
        if (list != null) {
          setState(
            () {
              newPage = false;
              getMovies(list);
            },
          );
          Navigator.pop(context);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color.fromRGBO(255, 200, 255, 0.8),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.filter_alt_outlined,
              color: Colors.white,
            ),
            onPressed: _openFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              itemCount: movies == null ? 0 : movies.length,
              itemBuilder: (BuildContext context, int index) {
                return ExpansionTile(
                  title: Text(
                    movies[index][0],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Image.network(
                    movies[index][1],
                    height: 100,
                    width: 100,
                    alignment: Alignment.topLeft,
                  ),
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        'Year: ' + movies[index][2],
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        'Rating: ' + movies[index][3],
                        style: const TextStyle(fontWeight: FontWeight.w400),
                      ),
                      tileColor: const Color.fromRGBO(220, 220, 220, 0.4),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
