import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:first_proj/src/final_project/containers/is_loading_container.dart';
import 'package:first_proj/src/final_project/containers/movie_container.dart';

import 'package:first_proj/src/final_project/models/movie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final List<Movie> _movies = <Movie>[];
  bool _isLoading = true;

  @override
  void initState() {

    super.initState();
    _getMovies();
  }

  Future<void> _getMovies() async {
    setState(() => _isLoading = true);
    const String url = 'https://yts.mx/api/v2/list_movies.json?page=3&limit=50';
    final Response response = await get(url);
    final String body = response.body;
    final List<dynamic> list = jsonDecode(body)['data']['movies'];
    final List<Movie> movieList = list //
        .map((dynamic json) => Movie.fromJson(json))
        .toList();
    setState(() {
      _movies.addAll(movieList);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // StoreProvider.of<AppState>(context).state.isLoading;
    // StoreProvider.of<AppState>(context).state.movies;
    return IsLoadingContainer(builder: (BuildContext context, bool isLoading) {
      return Scaffold(
        appBar: AppBar(),
        body: Builder(
          builder: (BuildContext context) {
            if (_isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return MoviesContainer(
              builder: (BuildContext context, BuiltList<Movie> movies) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                    crossAxisCount: 3,
                  ),
                  itemCount: _movies.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Movie movie = _movies[index];
                    return GridTile(
                      child: Image.network(movie.largeCoverImage),
                      footer: GridTileBar(title: Text(movie.title), subtitle: Text(movie.genres.join(', '))),
                    );
                  },
                );
              },
            );
            //
          },
        ),
      );
    });
  }
}
