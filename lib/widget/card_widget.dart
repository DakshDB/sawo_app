import 'package:flutter/material.dart';

import '../theme.dart';

class CardWidget extends StatelessWidget {
  final locationModel;
  final width;

  const CardWidget({
    Key? key,
    this.locationModel,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Card(
        shape: AppTheme.shape,
        elevation: 10.0,
        color: Theme.of(context).backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "IP ADDRESS",
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(
                locationModel.ipAddress,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "LOCATION",
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(locationModel.location,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText2),
              SizedBox(
                height: 20,
              ),
              Text(
                "TIMEZONE",
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(locationModel.timeZone,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText2),
              SizedBox(
                height: 20,
              ),
              Text(
                "ISP",
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(locationModel.isp,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText2),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
