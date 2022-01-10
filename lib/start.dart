import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:polish_congress_app/globals.dart';

import 'entity/NewsItem.dart';


class Start extends StatefulWidget {
  Start({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _StartState createState() => _StartState();

}


class _StartState extends State<Start> with TickerProviderStateMixin {
  late Future<List<NewsItem>> news;


  @override
  void initState(){
    super.initState();
    news = fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<NewsItem>>(
                future: news,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    ListView.builder(
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var currentItem = snapshot.data![index];
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 100),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(currentItem.title),
                              Text(currentItem.body),
                              Text(currentItem.time)
                            ],
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              )
    );
  }

  Future<List<NewsItem>> fetchNews() async {
    final response = await http.get(Uri.parse(Globals().getNewsUrl()));
    if (response.statusCode == 200) {
      print(response.body);

      // If the server did return a 200 OK response,
      // then parse the JSON.
      Iterable l = json.decode(response.body);
      return List<NewsItem>.from(l.map((model)=> NewsItem.fromJson(model)));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load news item');
    }
  }
}

