



import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foody_ui/services/color.service.dart';
import 'package:foody_ui/typdef/mytypedef.dart';
import 'package:foody_ui/util/text_style_util.dart';
import 'package:livingsmart_app/config/constants.dart';
import 'package:foody_ui/subui/slivers.subui.dart';
import 'package:livingsmart_app/services/navigator.service.dart';

class DriverHomeSubPage extends StatelessWidget {
  final DriverHomeSubPageVM vm;
  final GetIntData clickMenu;
  DriverHomeSubPage(this.vm, this.clickMenu);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(child:Column(children:[
      SizedBox(height:20),
      Container(
        padding:EdgeInsets.only(left:20),
        width:MediaQuery.of(context).size.width-50,
        height:50,
        child:driverInfo(context)),
      SizedBox(height:30),
      Container(
        padding:EdgeInsets.only(left:30, right:30, bottom:20, top:20),
        width:MediaQuery.of(context).size.width,
        height:400,
        child:stackMenu())
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
                            ),
    ]);
  }


  Widget stackMenu(){
    List<Widget> options = [];
    options.add(optionIcon(Icons.list, "Jobs", vm.jobCount, (){
      this.clickMenu(0);
    }));
    options.add(optionIcon(Icons.directions_walk, "Current", vm.currentJob, (){
      this.clickMenu(2);
    }));
    options.add(optionIcon(Icons.playlist_add_check, "Completed", vm.completedJob, (){
      this.clickMenu(1);
    }));

    return SliversSubUI.instance.stackOption(options, 2);
  }

  Widget optionIcon(IconData icon,String label, int count, NormalCallback click){
    return GestureDetector(onTap:click, child: Container(
          width:200,
          height:200,
          padding:EdgeInsets.all(40),
            decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [BoxShadow(color: Colors.white, offset: Offset(0, -2), blurRadius: 5.0)]),
      child:Column(children:[
      Text(count.toString(), style:TextStyleUtil.textBold(fontSz:30, tColor:ColorsService.instance.primaryColor())),
      Text(label, style:TextStyleUtil.textNormal(fontSz:12, tColor:Colors.grey)),
      Icon(icon, size:30, color:Colors.grey)
    ])));
  }




}

class DriverHomeSubPageVM{
  int jobCount=0;
  int currentJob;
  int completedJob;
  DriverHomeSubPageVM({this.jobCount=0, this.completedJob=0, this.currentJob=0});
}