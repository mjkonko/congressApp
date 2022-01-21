import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends StatefulWidget {
  Contact({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            child: Column(children: [
              Expanded(
                  child: GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                      ),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: [
                    _buildCard("About",
                        "https://polishcongress.com/about"), // ABOUT "lib/assets/images/"
                    _buildCard("Lunch Venues",
                        "https://www.polishcongress.com/suggested-venues"), // FOOD 'lib/assets/images/icon_venues.png'
                    _buildCard("Team",
                        "https://polishcongress.com/the-congress-crew"), // TEAM "lib/assets/images/icon_team.png"
                    _buildCard("Contact Us",
                        "https://polishcongress.com/contact-us"), // CONTACT "lib/assets/images/"
                    _buildCard("Instagram",
                        "https://www.instagram.com/congressofplstudents/"),
                    _buildCard("Messenger",
                        "http://m.me/congressofpolishstudentsocieties/"),
                    _buildCard("LinkedIn",
                        "https://www.linkedin.com/company/polishcongress/")
                  ]))
            ])));
  }

  void _launchURL(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }

  Card _buildCard(String img, String url) {
    return Card(
      child: InkWell(
        onTap: () {
          _launchURL(url);
        },
        child: Container(
          color: Color.fromRGBO(142, 13, 49, 0.7),
          child: Center(
              child: Text(img,
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.w200,
                      overflow: TextOverflow.fade))),
        ),
      ),
    );
  }
}
