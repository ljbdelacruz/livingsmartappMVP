



import 'package:clean_data/base/architechture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:foody_ui/components/buttons/block.button.dart';
import 'package:foody_ui/typdef/mytypedef.dart';
import 'package:livingsmart_app/config/constants.dart';
import 'package:livingsmart_app/pages/mstore/mstoretransaction.presenter.dart';
import 'package:livingsmart_app/services/color.service.dart';

class CancelOrderPage extends StatefulWidget{
  final GetStringData cancel;
  CancelOrderPage(this.cancel);
  @override
  CancelOrderPageState createState() => CancelOrderPageState();
}
class CancelOrderPageState extends State<CancelOrderPage> {  
  TextEditingController reasonT = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(child:Scaffold(body:bodyContent()));
  }
  Widget bodyContent(){
    return Column(children:[
      TextFormField(
        controller:this.reasonT,
        keyboardType: TextInputType.multiline,
        maxLines: 8,
        maxLength: 150,
      ),
      BlockButtonWidget(
                      text: Text(
                        "Cancel",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      color: ColorService.primaryColor(),
                      onPressed: () {
                        widget.cancel(this.reasonT.text);
                      },
      ),

    ]);
  }
}