import 'package:flutter/cupertino.dart';
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
                Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                          icon: FaIcon(FontAwesomeIcons.instagramSquare, color: Colors.white),
                          iconSize: 50,
                          onPressed: () { _launchURL('https://www.instagram.com/congressofplstudents/'); }
                      ),
                      IconButton(
                        // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                          icon: FaIcon(FontAwesomeIcons.facebookMessenger, color: Colors.white),
                          iconSize: 50,
                          onPressed: () { _launchURL('http://m.me/congressofpolishstudentsocieties/'); }
                      ),
                    ],
                  )
                ),
                Expanded(
                    child:
                        GridView(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                          ),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: [
                                _buildCard("lib/assets/images/","https://polishcongress.com/about"), // ABOUT
                                _buildCard('lib/assets/images/icon_venues.png',"https://www.polishcongress.com/suggested-venues"), // FOOD
                                _buildCard("lib/assets/images/icon_team.png","https://polishcongress.com/the-congress-crew"), // TEAM
                                _buildCard("lib/assets/images/","https://polishcongress.com/contact-us")  // CONTACT
                            ]
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

  Card _buildCard(img, url) {
    return Card(
        child:
            InkWell(
              onTap: () {
                _launchURL(url);
              },
              child: Container(
                width: 200.0,
                height: 200.0,
                child: Image(image: AssetImage(img)),
              ),
            ),
        );
  }

}