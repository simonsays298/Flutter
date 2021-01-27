import 'package:built_collection/built_collection.dart';
import 'package:first_proj/src/final_project/models/app_state.dart';
import 'package:first_proj/src/final_project/models/movie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class MoviesContainer extends StatelessWidget {
  const MoviesContainer({Key key, @required this.builder}) : super(key: key);

  final ViewModelBuilder<BuiltList<Movie>> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BuiltList<Movie>>(
      builder: builder,
      converter: (Store<AppState> store) {
        return store.state.movies;
      },
    );
  }
}
