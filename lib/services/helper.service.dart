



import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:livingsmart_app/config/constants.dart';

class Helper{
    static Widget getPrice(double myPrice, BuildContext context, {TextStyle style}) {
    if (style != null) {
      style = style.merge(TextStyle(fontSize: style.fontSize + 2));
    }
    try {
      if (myPrice == 0) {
        return Text('-', style: style ?? Theme.of(context).textTheme.subtitle1);
      }
      return RichText(
        softWrap: false,
        overflow: TextOverflow.fade,
        maxLines: 1,
        text: TextSpan(
                text: myPrice.toStringAsFixed(2) ?? '',
                style: style ?? Theme.of(context).textTheme.subtitle1,
                children: <TextSpan>[
                  TextSpan(
                      text: Constants.instance.currency,
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontSize: style != null ? style.fontSize - 4 : Theme.of(context).textTheme.subtitle1.fontSize - 4)),
                ],
              ),
      );
    } catch (e) {
      return Text('');
    }
  }
}