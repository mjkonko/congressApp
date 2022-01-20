import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class Map extends StatefulWidget {
  Map({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MapState createState() => _MapState();

}


class _MapState extends State<Map> with TickerProviderStateMixin {

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(initialCameraPosition:
                        CameraPosition(
                          target: LatLng(51.752022, -1.257677 ),
                          zoom: 14
                        ),
        myLocationEnabled: true,
        markers: Utilities._markers,
        onMapCreated: (GoogleMapController controller) => setState(() {
          controller.setMapStyle(Utilities.mapStyleJson);
        })
      )
    );
  }

}

class Utilities{
  static Set<Marker> _markers = {
    Marker(
        markerId: MarkerId('ox-uni-edmunds-1'),
        position: LatLng(51.75317160515247, -1.2499625439266937),
        infoWindow: InfoWindow(
            title: 'Oxford University: St. Edmund Hall',
            snippet: 'Friday Formal Venue'
        )
    ),
    Marker(
        markerId: MarkerId('ox-town-hall-1'),
        position: LatLng(51.751690843836684, -1.2571250844111337),
        infoWindow: InfoWindow(
            title: 'Oxford Town Hall',
            snippet: 'Saturday Ball Venue'
        )
    ),
    Marker(
        markerId: MarkerId('ox-uni-museum-nathist-1'),
        position: LatLng(51.758822515315714, -1.2555313746070507),
        infoWindow: InfoWindow(
            title: 'Oxford University Museum of Natural History',
            snippet: 'Friday Social Venue'
        )
    ),
    Marker(
        markerId: MarkerId('ox-uni-ex-schools-1'),
        position: LatLng(51.75245112312048, -1.2499640285864282),
        infoWindow: InfoWindow(
            title: 'Oxford Town Hall',
            snippet: 'Saturday Day Events\' Venue'
        )
    ),
    Marker(
        markerId: MarkerId('ox-sheldonian-thre-1'),
        position: LatLng(51.754435409975734, -1.2549810439266371),
        infoWindow: InfoWindow(
            title: 'Sheldonian Theatre',
            snippet: 'Friday Day Events\' Venue'
        )
    ),

  };

  static String mapStyleJson = '''
  [
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ebe3cd"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#523735"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f1e6"
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#c9b2a6"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#dcd2be"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#ae9e90"
      }
    ]
  },
  {
    "featureType": "landscape.natural",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dfd2ae"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dfd2ae"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#93817c"
      }
    ]
  },
  {
    "featureType": "poi.business",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#a5b076"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#447530"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f1e6"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#fdfcf8"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f8c967"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#e9bc62"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "road.highway.controlled_access",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e98d58"
      }
    ]
  },
  {
    "featureType": "road.highway.controlled_access",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#db8555"
      }
    ]
  },
  {
    "featureType": "road.local",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#806b63"
      }
    ]
  },
  {
    "featureType": "transit",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dfd2ae"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#8f7d77"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#ebe3cd"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dfd2ae"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#b9d3c2"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#92998d"
      }
    ]
  }
]
  ''';
}
