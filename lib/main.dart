import 'package:flutter/material.dart';
import 'package:polish_congress_app/agenda.dart';
import 'package:polish_congress_app/contact.dart';
import 'package:polish_congress_app/map.dart';
import 'package:polish_congress_app/start.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Congress App',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red)
              .copyWith(secondary: Colors.redAccent),
          scaffoldBackgroundColor: Color.fromRGBO(146, 7, 48, 1.0),
          focusColor: Color.fromRGBO(220, 220, 220, 1.0),
          fontFamily: ''),
      home: MyHomePage(title: 'XV Polish Congress'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,
            style: TextStyle(fontWeight: FontWeight.w200, fontSize: 17.5)),
        toolbarHeight: 22.0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/images/congress_bgd.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        bottom: TabBar(
          controller: _tabController,
          indicatorWeight: 1.5,
          automaticIndicatorColorAdjustment: true,
          indicatorColor: Color.fromRGBO(255, 255, 255, 1.0),
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.cloud_outlined),
              text: "News",
            ),
            Tab(
              icon: Icon(Icons.calendar_today),
              text: "Agenda",
            ),
            Tab(
              icon: Icon(Icons.pin_drop_outlined),
              text: "Map",
            ),
            Tab(
              icon: Icon(Icons.contact_support),
              text: "Info",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Center(child: Start(title: 'News')),
          Center(child: Agenda(title: 'Agenda')),
          Center(child: Map(title: 'Map')),
          Center(child: Contact(title: 'Info'))
        ],
      ),
    );
  }
}
