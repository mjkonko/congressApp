import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';


class Contact extends StatefulWidget {
  Contact({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ContactState createState() => _ContactState();

}


class _ContactState extends State<Contact> with TickerProviderStateMixin {
  String data = '''
  
  Get in touch with the Congress support team!
  
  Send an email to:
  info@polishcongress.com 
   
  or use our social media!
  ''';

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          alignment: Alignment.center,
          child :Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text("Contact the Team",
                      style: TextStyle(
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                ),
                Text(data, textAlign: TextAlign.center),
                Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                          icon: FaIcon(FontAwesomeIcons.instagramSquare),
                          iconSize: 50,
                          onPressed: () { _launchURL('https://www.instagram.com/congressofplstudents/'); }
                      ),
                      IconButton(
                        // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                          icon: FaIcon(FontAwesomeIcons.facebookMessenger),
                          iconSize: 50,
                          onPressed: () { _launchURL('http://m.me/congressofpolishstudentsocieties/'); }
                      ),
                    ],
                  )
                )
            ]
          )
    )
    );
  }

  void _launchURL(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }

}