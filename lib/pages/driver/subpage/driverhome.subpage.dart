



import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:livingsmart_app/config/constants.dart';

class DriverHomeSubPage extends StatelessWidget {
  DriverHomeSubPage();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(child:Column(children:[
      SizedBox(height:20),
      Container(
        padding:EdgeInsets.only(left:20),
        width:MediaQuery.of(context).size.width-50,
        height:50,
        child:driverInfo(context))
    ]));
  }

  Widget driverInfo(BuildContext context){
    return Row(children:[
      SizedBox(
                              width: 55,
                              height: 55,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(300),
                                onTap: () {
                                  // Navigator.of(context).pushNamed('/Profile');
                                },
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage( Constants.instance.noImageDefault),
                                ),
      )),
      SizedBox(width:20),
      Column(
                              children: <Widget>[
                                Text(
                                  Constants.instance.session.user.name,
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                                Text(
                                  Constants.instance.session.user.email,
                                  style: Theme.of(context).textTheme.caption,
                                )
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            )
    ]);
  }


}