import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:polish_congress_app/globals.dart' as global;
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
    leading: Container(
      padding: EdgeInsets.only(right: 12.0),
      decoration: new BoxDecoration(
          border: new Border(
              right: new BorderSide(width: 1.0, color: Colors.white24))),
      child: Icon(Icons.event, color: Colors.white),
    ),
    title: Text(
      item.name,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),

    subtitle: Row(
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Padding(
              padding: EdgeInsets.only(left: 0.0, top: 9.0, right: 0.0),
              child: Text(DateTime.parse(item.time).toLocal().toString(),
                  style: TextStyle(color: Colors.white)),
          ),
        ),
        Expanded(
          flex: 4,
          child: Padding(
              padding: EdgeInsets.only(left: 0.0, top: 9.0, right: 0.0),
              child: FutureBuilder<String>(
                future: fetchSpeaker(item.speaker.toString()),
                builder:
                  (context, snapshot) {
                    if (snapshot.hasError) {
                      print(snapshot.error.toString());
                      return const Center(
                        child: Text('An error has occurred!'),
                      );
                    } else if (snapshot.hasData) {
                      return Text(snapshot.data!);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
              )

          ),
        ),
        Expanded(
          flex: 4,
          child: Padding(
              padding: EdgeInsets.only(left: 0.0, top: 9.0, right: 0.0),
              child: FutureBuilder<String>(
                future: fetchVenue(item.venue.toString()),
                builder:
                  (context, snapshot) {
                    if (snapshot.hasError) {
                      print(snapshot.error.toString());
                      return const Center(
                        child: Text('An error has occurred!'),
                      );
                    } else if (snapshot.hasData) {
                      return Text(snapshot.data!);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
              )

          ),
        )
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: agenda.length,
      itemBuilder: (context, index) {
        return makeCard(agenda[index]);
      },
    );
  }
}

Future<List<AgendaItem>> fetchAgenda(http.Client client) async {
  final response = await client.get(Uri.parse(Globals().getAgendaUrl()));

  if (response.statusCode == 200) {
    print(response.body);

    return compute(parseAgenda, response.body.toString());
  } else {
    throw Exception('Failed to load agenda item');
  }
}

List<AgendaItem> parseAgenda(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<AgendaItem>((json) => AgendaItem.fromJson(json)).toList();
}

Future<String> fetchSpeaker(String id) async{
  final response = await http.get(
      Uri.parse(Globals().getSpeaker(id))
  );
  if (response.statusCode == 200) {
    var res = json.decode(response.body);

    return SpeakerItem.fromJson(res).name;
  } else {
    // show error
    throw new Exception("Failed to fetch speaker " + id);
  }
}
Future<String> fetchVenue(String id) async{
  final response = await http.get(
      Uri.parse(Globals().getVenue(id))
  );
  if (response.statusCode == 200) {
    var res = json.decode(response.body);

    return VenueItem.fromJson(res).name;
  } else {
    // show error
    throw new Exception("Failed to fetch venue " + id);
  }
}


