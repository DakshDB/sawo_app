import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';

class MovingMarker extends StatefulWidget {

  static final GlobalKey<_MovingMarker> globalKey = GlobalKey();

  MovingMarker() : super(key: globalKey);

  @override
  _MovingMarker createState() => _MovingMarker();
}

class _MovingMarker extends State<MovingMarker> {
  Marker? _marker;


  @override
  void initState() {
    super.initState();

    setState(() {
      _marker = Marker(
        width: 40.0,
        height: 40.0,
        point: LatLng(17.4427, 78.47514),
        builder: (ctx) => Container(
          child: SvgPicture.asset("assets/icon-location.svg"),
        ),
      );
    });
  }


  updateStatus(latLang) {
    setState(() {
      _marker = Marker(
        width: 40.0,
        height: 40.0,
        point: latLang,
        builder: (ctx) => Container(
          child: SvgPicture.asset("assets/icon-location.svg"),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MarkerLayerWidget(options: MarkerLayerOptions(markers: [_marker!]));
  }
}
