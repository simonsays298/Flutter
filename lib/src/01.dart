import 'dart:convert';
import 'package:http/http.dart';

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

// Future<void> main() async {
//   final Response resp = await get('https://yts.mx/api/v2/list_movies.json');
//   final Map<String, dynamic> map = jsonDecode(resp.body);
//   print(map['data']['movies'][0]['title']);
//   final List<dynamic> moviesList = map['data']['movies'];
//   for (int i = 0; i < moviesList.length; i++) {
//     print(moviesList[i]['title']);
//   }
// }
Future<void> main() async {
  final Response resp = await get('https://yts.mx/api/v2/list_movies.json');
  final Map<String, dynamic> map = jsonDecode(resp.body);
  for (int i = 0; i < 20; i++) {
    print(map['data']['movies'][i]['title']);
  }

  // final List<String> items = data.split('<a href="/img/flags');
  // for(final String item in items.skip(1) ){
  //   final List<String> countryName = item.split('padding-top:10px">');
  //   print(countryName[1]);
  //   final String flagUrl = 'https://www.worldmeters.info/img/flags${item.split('"')[0]}';
  // }
}
