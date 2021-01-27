import 'package:first_proj/src/final_project/actions/get_movies.dart';
import 'package:first_proj/src/final_project/data/yts_api.dart';
import 'package:first_proj/src/final_project/models/app_state.dart';
import 'package:first_proj/src/final_project/models/movie.dart';
import 'package:flutter/cupertino.dart';
import 'package:redux/redux.dart';

class AppMiddleware {
  const AppMiddleware({@required YtsApi ytsApi})
      : assert(ytsApi != null),
        _ytsApi = ytsApi;
  final YtsApi _ytsApi;

  List<Middleware<AppState>> get middleware {
    return <Middleware<AppState>>[
      _getMovies,
    ];
  }

  Future<void> _getMovies(Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);
    if (action is GetMovies) {
      try {
        final List<Movie> movies = await _ytsApi.getMovies();
        final GetMoviesSuccessful successful = GetMoviesSuccessful(movies);
        store.dispatch(successful);
      } catch (e) {
        final GetMoviesError error = GetMoviesError(e);
        store.dispatch(error);
      }
    }
  }
}
