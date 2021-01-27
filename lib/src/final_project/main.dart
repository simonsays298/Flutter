import 'package:first_proj/src/final_project/data/yts_api.dart';
import 'package:first_proj/src/final_project/middleware/app_middleware.dart';
import 'package:first_proj/src/final_project/reducer/reducer.dart';
import 'package:first_proj/src/final_project/models/app_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:first_proj/src/final_project/presentation/homepage.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart';

import 'actions/get_movies.dart';

void main() {
  final Client client = Client();
  final YtsApi ytsApi = YtsApi(client: client);
  final AppMiddleware middleware = AppMiddleware(ytsApi: ytsApi);
  final AppState initialState = AppState();
  final Store<AppState> store = Store<AppState>(
    reducer,
    initialState: initialState,
    middleware: middleware.middleware,
  );

  store.dispatch(const GetMovies());
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key, @required this.store}) : super(key: key);
  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: const MaterialApp(
        home: Homepage(),
      ),
    );
  }
}
