



import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foody_ui/util/text_style_util.dart';

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
  Widget productItemTBView(BuildContext context, String image, String name, String qty){
    return Row(children:[
            ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                child: CachedNetworkImage(
                  height: 90,
                  width: 90,
                  fit: BoxFit.cover,
                  imageUrl: image,
                  placeholder: (context, url) => Image.asset(
                    "assets/images/loader/loading.gif",
                    fit: BoxFit.cover,
                    height: 90,
                    width: 90,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            SizedBox(width:10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Container(
                  width:MediaQuery.of(context).size.width-140,
                  child: Text(name, style:TextStyleUtil.textBold(fontSz:13, tColor: Colors.grey))),
                Text("x"+qty, style:TextStyleUtil.textNormal(fontSz:12, tColor: Colors.grey)),
            ])
    ]);
  }


}