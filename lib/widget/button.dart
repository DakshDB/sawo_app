
import 'package:flutter/material.dart';

import '../theme.dart';



class ButtonWidget extends StatelessWidget {

  final onPressed;
  final buttonText;
  const ButtonWidget({Key? key, this.onPressed, this.buttonText}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 6.0,
      shape: AppTheme.shape,
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.height / 6,
          vertical: MediaQuery.of(context).size.height / 50),
      color: Theme.of(context).highlightColor,
      child: Text(buttonText,
        style: Theme.of(context)
            .textTheme
            .button),
      onPressed: onPressed
    );

  }
}

