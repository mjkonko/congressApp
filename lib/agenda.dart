import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:polish_congress_app/globals.dart';
import 'package:polish_congress_app/entity/AgendaItem';


class Agenda extends StatefulWidget {
  Agenda({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _AgendaState createState() => _AgendaState();

  }


class _AgendaState extends State<Agenda> with TickerProviderStateMixin {
  late Future<List<AgendaItem>> agenda;

  @override
  void initState(){
    super.initState();
    agenda = fetchAgenda();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AgendaItem>>(
      future: agenda,
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
                    Text(currentItem.name),
                    Text(currentItem.time),
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
    );
  }


  Future<List<AgendaItem>> fetchAgenda() async {
    final response = await http.get(Uri.parse(Globals().getAgendaUrl()));

    if (response.statusCode == 200) {
      print(response.body);

      // If the server did return a 200 OK response,
      // then parse the JSON.
      Iterable l = json.decode(response.body);
      return List<AgendaItem>.from(l.map((model)=> AgendaItem.fromJson(model)));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load agenda item');
    }
  }
}
