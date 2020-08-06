



import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WidgetUI{

  static WidgetUI instance=new WidgetUI();


  Widget iconButton({IconData icon = Icons.notifications,Color tColor = Colors.grey, double fontSz = 20}){
    return GestureDetector(onTap:(){}, child: IconButton(
            icon: Icon(
              Icons.notifications,
              size:fontSz,
              color: tColor,
            ),
            onPressed: () {
              // NavigatorService.instance.mstoreNotification(context);
            },
          )
    );
  }

}