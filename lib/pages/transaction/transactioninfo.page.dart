



import 'package:clean_data/base/architechture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:foody_ui/util/text_style_util.dart';
import 'package:livingsmart_app/components/widgets.ui.dart';
import 'package:livingsmart_app/config/constants.dart';
import 'package:livingsmart_app/pages/transaction/transactioninfo.presenter.dart';
import 'package:livingsmart_app/services/color.service.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TransactionInfoPage extends CleanPage {

  @override
  TransactionInfoPageState createState() => TransactionInfoPageState();
}

class TransactionInfoPageState extends CleanPageState<TransactionInfoPresenter> {
  @override
  TransactionInfoPresenter createPresenter() {
    return TransactionInfoPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(child:Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Transaction Info",
          style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
        )
      ),
      body:SingleChildScrollView(child:Column(children:[
      SizedBox(height:20),
      statusInfo(),
      SizedBox(height:20),
      driverInfo(),
      SizedBox(height:20),
      productsList(),
      SizedBox(height:20),
      feeInfo()
    ])),
    bottomNavigationBar: transactionFee(),
    ));
  }

  Widget statusInfo(){
    return presenter.transactionInfo != null ? Container(
      padding:EdgeInsets.only(left:30, right:30),
      width: MediaQuery.of(context).size.width,
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
      Text(presenter.transactionInfo.details.status.toUpperCase(), style:TextStyleUtil.textBold(fontSz:15)),
      Text("#"+presenter.transactionInfo.details.transaction_code, style:TextStyleUtil.textNormal(fontSz:12))
    ])) : CircularPercentIndicator(radius: 40, animation:true, animationDuration: 2000,);
  }

  Widget driverInfo(){
    return presenter.transactionInfo != null && presenter.transactionInfo.details.rider_name != "null" ?  Container(
      child:Column(children:[
        Text(presenter.transactionInfo.details.rider_name, style:TextStyleUtil.textBold(fontSz:12)),
        Text(presenter.transactionInfo.details.rider_mobile, style:TextStyleUtil.textNormal(fontSz:11))
      ])
    ) : Container();
  }

  Widget productsList(){
    if(presenter.transactionInfo != null){
      List<Widget> items = [];
        presenter.transactionInfo.products.forEach((element) { 
          items.add(WidgetUI.instance.productItemTBView(context, element.image != null ? Constants.instance.baseURL+element.image : Constants.instance.noImageDefault, element.name, element.quantity.toString()));
        });
      return Column(children:items);
    }else{
      return Container();
    }
  }

  Widget feeInfo(){
    return presenter.transactionInfo != null ? Container(
      padding:EdgeInsets.only(left:30, right:30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
      Text(presenter.transactionInfo.details.payment_type == "cod" ? "Cash On Delivery" : "Others", style:TextStyleUtil.textBold(fontSz:15, tColor:Colors.grey)),
      SizedBox(height:20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
        Text("Sub Total:"),
        Text(Constants.instance.currency+" "+presenter.subtotal.toString()),
      ]),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
        Text("Delivery Fee:"),
        Text(Constants.instance.currency+" "+presenter.transactionInfo.details.delivery_fee),
      ]),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
        Text("Admin Commission:"),
        Text(Constants.instance.currency+" "+presenter.transactionInfo.details.admin_commission),
      ])
    ])) : Container();
  }

  Widget transactionFee(){
    return Container(
      color:ColorService.primaryColor(),
      padding:EdgeInsets.only(left:30, right:30),
      width:MediaQuery.of(context).size.width,
     height:100,
     child:Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:[
      Text("Total Amount: "+Constants.instance.currency+" "+presenter.calculateBill().toString(), style:TextStyleUtil.textBold(fontSz:15, tColor:Colors.white)),
      Container()
    ]));
  }

}