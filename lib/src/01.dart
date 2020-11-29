import 'dart:convert';
import "package:http/http.dart";

// int main(){
//   get('https://yts.mx/api/v2/list_movies.json').then((Response response) {
//     Map<String, dynamic> map = jsonDecode(response.body);
//     print(map["data"]["movies"][0]["title"]);
//   });
// }
// Future<void> main() async {
//   final Response resp = await get('https://yts.mx/api/v2/list_movies.json');
//   Map<String, dynamic> map = jsonDecode(resp.body);
//   print(map["data"]["movies"][0]["title"]);
// }

Future<void> main() async {
  final Response resp = await get('https://yts.mx/api/v2/list_movies.json');
  Map<String, dynamic> map = jsonDecode(resp.body);
  print(map["data"]["movies"][0]["title"]);
  List<dynamic> moviesList = map['data']['movies'];
  for (int i = 0; i < moviesList.length; i++) {
    print(moviesList[i]['title']);
  }
}
