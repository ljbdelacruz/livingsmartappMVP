



import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foody_ui/typdef/mytypedef.dart';
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


  Widget clickableTextField(NormalCallback click, NormalCallback iconClick,{Color unColor = Colors.red, Color tColor = Colors.grey, String hintText=""}){
    return InkWell(
      onTap: () {
        // Navigator.of(context).push(SearchModal());
        click();
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: unColor,
            ),
            borderRadius: BorderRadius.circular(4)),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 12, left: 0),
              child: Icon(Icons.search, color: tColor),
            ),
            Expanded(
              child: Text(
                hintText,
                maxLines: 1,
                style: TextStyleUtil.textNormal(fontSz:12, tColor: tColor),
              ),
            ),
            InkWell(
              onTap: () {
                // onClickFilter('e');
                iconClick();
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 5, left: 5, top: 3, bottom: 3),
                child: Icon(Icons.filter_list, color: tColor,
              ),
            )
            ),
          ],
        ),
      ),
    );
  }


}