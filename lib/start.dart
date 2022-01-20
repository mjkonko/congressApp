import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
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
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<NewsItem>>(
          future: fetchNews(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error.toString());
              return const Center(
                child: Text('An error has occurred!'),
              );
            } else if (snapshot.hasData) {
              return NewsList(list: snapshot.data!);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )
    );
  }
}

class NewsList extends StatelessWidget {
  const NewsList({Key? key, required this.list}) : super(key: key);

  final List<NewsItem> list;

  Text parseDT(DateTime dt) => Text(
      dt.day.toString() + "/" + dt.month.toString() + " " + DateFormat('hh:mm').format(dt),
      style: TextStyle(color: Colors.white,
          fontWeight: FontWeight.w200,
          fontSize: 8,
          letterSpacing: 1.5
      )
  );

  Card makeCard(NewsItem item) => Card(
    elevation: 10.0,
    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
      decoration: BoxDecoration(color: Color.fromRGBO(61, 58, 58, 0.48)),
      child: makeListTile(item),
    ),
  );

  ListTile makeListTile(NewsItem item) => ListTile(
    contentPadding:
    EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
    leading: Container(
      padding: EdgeInsets.only(right: 12.0),
      decoration: new BoxDecoration(
          border: new Border(
              right: new BorderSide(width: 1.0, color: Colors.white24))),
      child: Icon(Icons.cloud, color: Colors.white),
    ),
    title: Text(
      item.title,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),

    subtitle:
    Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Padding(
                  padding: EdgeInsets.only(left: 0.0, top: 9.0),
                  child: Text(item.body,
                      style: TextStyle(color: Colors.white))),
            )
          ],
        ),
          Row(
            children: <Widget>[
              Expanded(
              flex: 4,
              child: Padding(
                  padding: EdgeInsets.only(left: 0.0, top: 9.0),
                  child: parseDT(DateTime.parse(item.time))
              )
            )
          ]
        )
      ]
    )
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      shrinkWrap: true,
      reverse: true,
      cacheExtent: 30.0,
      itemBuilder: (context, index) {
        return makeCard(list[index]);
      },
    );
  }
}

Future<List<NewsItem>> fetchNews(http.Client client) async {
  final response = await client.get(Uri.parse(Globals().getNewsUrl()),
      headers: {
        'Accept': 'application/json; charset=UTF-8'
      });

  if (response.statusCode == 200) {
    return compute(parseNews, response.bodyBytes.toList());
  } else {
    throw Exception('Failed to load news items');
  }
}

List<NewsItem> parseNews(List<int> responseBytes) {
  final parsed = jsonDecode(utf8.decode(responseBytes)).cast<Map<String, dynamic>>();

  List<NewsItem> list = parsed.map<NewsItem>((json) => NewsItem.fromJson(json)).toList();
  list.sort((item1, item2) => item1.id.compareTo(item2.id));
  return list;
}

