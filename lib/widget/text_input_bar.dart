import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TextInputBarWidget extends StatelessWidget {
  final onPressed;
  final hintText;
  final textController;

  const TextInputBarWidget(
      {Key? key, this.onPressed, this.hintText, this.textController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextField(
        controller: textController,
        decoration: InputDecoration(
            hintText: '0.0.0.0',
            hintStyle: Theme.of(context).textTheme.bodyText1,
            filled: true,
            fillColor: Theme.of(context).backgroundColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            isDense: true,
            suffixIcon: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Theme.of(context).indicatorColor,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: IconButton(
                icon: SvgPicture.asset("assets/icon-arrow.svg"),
                onPressed: onPressed
              ),
            )),
      ),
    );
  }
}
