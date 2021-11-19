import 'dart:async';

import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sawo_app/keys.dart';
import 'package:sawo_app/model/location_model.dart';
import 'package:sawo_app/widget/card_widget.dart';
import 'package:sawo_app/widget/marker.dart';
import 'package:sawo_app/widget/text_input_bar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const snackBarDuration = Duration(seconds: 3);

  final snackBar = SnackBar(
    content: Text('Press back again to leave'),
    duration: snackBarDuration,
  );

  DateTime? backButtonPressTime;

  LocationModel _locationModel = LocationModel(
      ipAddress: "-",
      location: "-",
      timeZone: "-",
      isp: "-",
      latLng: LatLng(28.70, 77.10));

  var _ipAddressController = TextEditingController();
  var _mapController = MapController();
  var _marker = MovingMarker();

  @override
  void initState() {
    super.initState();
    Ipify.geo(ipifyAPIKey).then((value) {
      setLocationData(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final availableHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final availableWidth =
        MediaQuery.of(context).size.width - MediaQuery.of(context).padding.left;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: WillPopScope(
            onWillPop: () => handleWillPop(context),
            child: Stack(children: [
              Column(
                children: [
                  Container(
                    height: availableHeight / 3,
                    child: Image.asset(
                      "assets/pattern-bg.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    height: 2 * availableHeight / 3,
                    child: FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                        center: _locationModel.latLng,
                      ),
                      children: [
                        TileLayerWidget(
                            options: TileLayerOptions(
                                urlTemplate:
                                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                subdomains: ['a', 'b', 'c'])),
                        _marker,
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 40,
                    ),
                    Text(
                      "IP Address Tracker",
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(color: Theme.of(context).primaryColor),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 40,
                    ),
                    TextInputBarWidget(
                      onPressed: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        await Ipify.geo(ipifyAPIKey,
                                ip: _ipAddressController.text)
                            .then((value) => setLocationData(value))
                            .onError((error, stackTrace) {

                              setState(() {
                                _locationModel = LocationModel(
                                    ipAddress: "-",
                                    location: "-",
                                    timeZone: "-",
                                    isp: "-",
                                    latLng: LatLng(28.70, 77.10));
                              });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Invalid IP Address !! Try Again'),
                          ));

                        });
                      },
                      textController: _ipAddressController,
                      hintText: '0.0.0.0',
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 40,
                    ),
                    CardWidget(
                      locationModel: _locationModel,
                      width: availableWidth,
                    )
                  ],
                ),
              )
            ])),
      ),
    );
  }

  setLocationData(geoData) {
    setState(() {
      _locationModel = LocationModel(
          ipAddress: geoData.ip,
          location: geoData.location.region +
              " " +
              geoData.location.country +
              " " +
              geoData.location.postalCode,
          timeZone: "UTC " + geoData.location.timezone,
          isp: geoData.isp,
          latLng: LatLng(geoData.location.lat, geoData.location.lng));
      MovingMarker.globalKey.currentState!.updateStatus(_locationModel.latLng);
      _mapController.move(_locationModel.latLng, 13);
    });
  }

  Future<bool> handleWillPop(BuildContext context) async {
    final now = DateTime.now();
    final backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
        backButtonPressTime == null ||
            now.difference(backButtonPressTime!) > snackBarDuration;

    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      backButtonPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }

    return true;
  }
}
