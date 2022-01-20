import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:polish_congress_app/entity/AgendaItem';

import 'entity/SpeakerItem.dart';
import 'entity/VenueItem.dart';
import 'globals.dart';


class Agenda extends StatefulWidget {
  Agenda({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _AgendaState createState() => _AgendaState();

  }

class _AgendaState extends State<Agenda> with TickerProviderStateMixin {
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<AgendaItem>>(
                future: fetchAgenda(http.Client()),
                builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      print(snapshot.error.toString());
                      return const Center(
                        child: Text('An error has occurred!'),
                      );
                    } else if (snapshot.hasData) {
                      return AgendaList(agenda: snapshot.data!);
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

class AgendaList extends StatelessWidget {
  const AgendaList({Key? key, required this.agenda}) : super(key: key);

  final List<AgendaItem> agenda;

  Text parseDT(DateTime dt) => Text(
      DateFormat('dd/MM/yyyy').format(dt)
        + " " + DateFormat('HH:mm').format(dt),
      style: TextStyle(color: Colors.white,
          fontWeight: FontWeight.bold,
          backgroundColor: Color.alphaBlend(Color.fromRGBO(255, 32, 32, 0.2), Color.fromRGBO(106, 32, 32, 0.6)),
          letterSpacing: 3
      )
  );

  Card makeCard(AgendaItem item) => Card(
    elevation: 10.0,
    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
      decoration: BoxDecoration(color: Color.fromRGBO(61, 58, 58, 0.6)),
      child: makeListTile(item),
    ),
  );

  ListTile makeListTile(AgendaItem item) => ListTile(
    contentPadding:
    EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
    subtitle: Column(
      children: <Widget>[
        Divider(
          color: Colors.white,
          height: 20,
          thickness: 0.5,
          indent: 10,
          endIndent: 10,
        ),
        Padding(
              padding: EdgeInsets.only(left: 0.0, top: 1.0, right: 0.0),
              child: parseDT(DateTime.parse(item.time)),
              ),
        Divider(
          color: Colors.white,
          height: 20,
          thickness: 0.5,
          indent: 10,
          endIndent: 10,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child:
                Padding(
                  padding: EdgeInsets.only(left: 8.0, top: 20.0, right: 0.0),
                  child: FutureBuilder<String>(
                    future: fetchSpeaker(item.speaker.toString()),
                    builder:
                        (context, snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error.toString());
                        return const Center(
                            child: Text('An error has occurred!',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200,
                                    overflow: TextOverflow.fade
                                )));
                      } else if (snapshot.hasData) {
                        return Text(snapshot.data!,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w200,
                                overflow: TextOverflow.fade
                            )
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  )
              )
            ),
            Expanded(
              child:
                Padding(
                    padding: EdgeInsets.only(left: 30.0, top: 20.0, right: 0.0),
                    child: FutureBuilder<String>(
                      future: fetchVenue(item.venue.toString()),
                      builder:
                          (context, snapshot) {
                        if (snapshot.hasError) {
                          print(snapshot.error.toString());
                          return const Center(
                              child: Text('An error has occurred!',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w200,
                                      overflow: TextOverflow.fade
                                  )));
                        } else if (snapshot.hasData) {
                          return Text(snapshot.data!,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w200,
                                  overflow: TextOverflow.fade
                              )
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    )
                )
            )
          ],
        ),
        Divider(
          color: Colors.white,
          height: 10,
          thickness: 0.5,
          indent: 10,
          endIndent: 10,
        ),
        Row(
          children:[
            Flexible(
              child:
                Padding(
                    padding: EdgeInsets.only(left: 8.0, top: 20.0, right: 8.0),
                    child: Text(item.description,
                                  softWrap: true,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w200,
                                      overflow: TextOverflow.fade,
                                  ),
                    )
                ),
              fit: FlexFit.loose,
            )
          ]
        ),
        Divider(
          color: Colors.white,
          height: 40,
          thickness: 0.5,
          indent: 10,
          endIndent: 10,
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: agenda.length,
      cacheExtent: 50.0,
      itemBuilder: (context, index) {
        return new ExpansionTile(
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Icon(Icons.event, color: Colors.white),
          ),
          title: Text(
                    agenda[index].name,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
          children: [
            makeListTile(agenda[index])
          ],
        );
      },
    );
  }
}

Future<List<AgendaItem>> fetchAgenda(http.Client client) async {
  final response = await client.get(Uri.parse(Globals().getAgendaUrl()),
      headers: {
        'Accept': 'application/json; charset=UTF-8'
      }
    );

  if (response.statusCode == 200) {
    return compute(parseAgenda, response.bodyBytes.toList());
  } else {
    throw Exception('Failed to load agenda item');
  }
}

List<AgendaItem> parseAgenda(List<int> responseBytes) {
  final parsed = json.decode(utf8.decode(responseBytes)).cast<Map<String, dynamic>>();

  List<AgendaItem> list = parsed.map<AgendaItem>((json) => AgendaItem.fromJson(json)).toList();
  list.sort((item1, item2) => item1.id.compareTo(item2.id));

  return list;
}

Future<String> fetchSpeaker(String id) async{
  final response = await http.get(
      Uri.parse(Globals().getSpeaker(id)),
      headers: { 'Accept': 'application/json; charset=UTF-8' }
  );
  if (response.statusCode == 200) {
    var res = json.decode(utf8.decode(response.bodyBytes));
    print(response.body);
    return SpeakerItem.fromJson(res).name;
  } else {
    // show error
    throw new Exception("Failed to fetch speaker " + id);
  }
}
Future<String> fetchVenue(String id) async{
  final response = await http.get(
      Uri.parse(Globals().getVenue(id)),
      headers: { 'Accept': 'application/json; charset=UTF-8' }
  );
  if (response.statusCode == 200) {
    var res = json.decode(utf8.decode(response.bodyBytes));

    return VenueItem.fromJson(res).name;
  } else {
    // show error
    throw new Exception("Failed to fetch venue " + id);
  }
}


