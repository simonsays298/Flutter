import 'dart:collection';
import 'dart:convert';
import 'dart:async';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

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
  final TextEditingController controller = TextEditingController();
  Map<String, dynamic> map = Map<String, dynamic>();
  List<String> titleMovies = List<String>();
  List<String> photosMovies = List<String>();
  int page_number = 1;
  bool erased = false;
  ScrollController _scrollController = new ScrollController();
  bool new_page = false;
  LinkedHashSet<String> set1 = new LinkedHashSet<String>();
  LinkedHashSet<String> set2 = new LinkedHashSet<String>();

  Future<void> getMovies(List<String> list) async {
    // LinkedHashSet<String> set1 = new LinkedHashSet<String>();
    // LinkedHashSet<String> set2 = new LinkedHashSet<String>();
    if (new_page == false) {
      titleMovies.clear();
      photosMovies.clear();
      set1.clear();
      set2.clear();
    }

    for (int i = 0; i < list.length; i++) {
      final Response resp = await get(
          'https://yts.mx/api/v2/list_movies.json?genre=' +
              list[i] +
              '&page=$page_number');

      setState(() {
        map = jsonDecode(resp.body);
        // page_number++;
        List<dynamic> moviesList = map["data"]["movies"];
        for (int j = 0; j < moviesList.length; j++) {
          set1.add(map["data"]["movies"][j]["title"]);
          set2.add(map["data"]["movies"][j]["medium_cover_image"]);
        }
        titleMovies = set1.toList();
        photosMovies = set2.toList();
      });
    }
    page_number++;

    print(map["data"]["movies"][0]["medium_cover_image"]);
  }

  List<String> countList = [
    "all",
    "Action",
    "Adventure",
    "Animation",
    "Biography",
    "Comedy",
    "Crime",
    "Documentary",
    "Drama",
    "Family",
    "Fantasy",
    "History",
    "Horror",
    "Musical",
    "Mystery",
    "Thriller",
    "Reality-Tv",
    "Romance",
    "Sci-Fi",
    "War",
    "Western",
  ];
  List<String> selectedCountList = [];

  List<String> resList = ['all'];

  @override
  void initState() {
    getMovies(['all']);
    setState(() {
      _scrollController.addListener(() {
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100) {
          new_page = true;
          getMovies(resList);
        }
      });
    });
    super.initState();
    erased = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  void _openFilterDialog() async {
    erased = false;
    await FilterListDialog.display(context,
        allTextList: countList,
        height: 480,
        borderRadius: 20,
        headlineText: "Choose your genre",
        searchFieldHintText: "Search Here", onApplyButtonClick: (list) {
      resList = list;
      page_number = 1;
      if (list != null) {
        setState(() {
          new_page = false;
          getMovies(list);
        });
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              icon: Icon(
                Icons.filter_alt_outlined,
                color: Colors.white,
              ),
              onPressed: _openFilterDialog)
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: resList == null ? 0 : resList.length,
              itemBuilder: (BuildContext context, int index) {
                // return Card(
                //   child: Container(
                //     width: 300,
                //     height: 100,
                //     child: Row(
                //       children: [
                //         Image.network(
                //           photosMovies[index],
                //         ),
                //         Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Text(titleMovies[index]),
                //         ),
                //       ],
                //     ),
                //   ),
                // );
                // if(index == titleMovies.length){
                //   getMovies(resList);
                // }
                // return RawChip(
                //   label: Text(resList[index]),
                //   avatar: InkWell(
                //     onTap: (){
                //
                //     },
                //     child: Icon(
                //       Icons.remove_circle_outline,
                //       color: Colors.red,
                //     ),
                //   ),
                //   backgroundColor: Colors.lightGreenAccent,
                // );
                print(erased);
                return erased
                    ? SizedBox(
                        height: 0,
                        width: 0,
                      )
                    : Chip(
                        deleteIcon: Icon(
                          Icons.remove_circle_outline,
                          size: 15,
                          color: Colors.redAccent,
                        ),
                        label: Text(resList[index]),
                        deleteButtonTooltipMessage: 'erase',
                        onDeleted: () {
                          setState(() {
                            erased = true;
                          });
                        },
                        backgroundColor: Colors.lightGreenAccent,
                      );
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView.builder(
              controller: _scrollController,
              // shrinkWrap: true,
              // gridDelegate:
              // const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
              shrinkWrap: true,
              itemCount: titleMovies == null ? 0 : titleMovies.length,

              itemBuilder: (BuildContext context, int index) {
                // return Card(
                //   child: Container(
                //     width: 300,
                //     height: 100,
                //     child: Row(
                //       children: [
                //         Image.network(
                //           photosMovies[index],
                //         ),
                //         Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Text(titleMovies[index]),
                //         ),
                //       ],
                //     ),
                //   ),
                // );
                // if(index == titleMovies.length){
                //   getMovies(resList);
                // }
                return ExpansionTile(
                  title: Text(titleMovies[index]),
                  // backgroundColor: Colors.tealAccent,
                  subtitle: Image.network(
                    photosMovies[index],
                    height: 100,
                    width: 100,
                    alignment: Alignment.topLeft,
                  ),
                  children: <Widget>[
                    ListTile(
                      title: Image.network(
                        photosMovies[index],
                        height: 200,
                        width: 200,
                        alignment: Alignment.topLeft,
                      ),
                    )
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
