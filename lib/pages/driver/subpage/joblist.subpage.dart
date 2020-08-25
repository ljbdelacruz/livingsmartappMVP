


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';
import 'package:foody_ui/components/buttons/buttonloader.buttons.dart';
import 'package:foody_ui/components/header/tabbed1.header.dart';
import 'package:clean_data/model/delivery.dart';
import 'package:foody_ui/components/progress/circularloading.progress.dart';
import 'package:foody_ui/services/color.service.dart';
import 'package:foody_ui/typdef/mytypedef.dart';
import 'package:foody_ui/util/text_style_util.dart';
import 'package:livingsmart_app/components/widgets.ui.dart';

class JobListSubPage extends StatelessWidget {
  final JobListSubPageVM vm;
  final GetStringData viewInfo;
  final GetStringData acceptjob;
  final GetStringData deliveredJob;
  final GetStringData pickupDirection;
  final GetStringData deliveryDirection;

  JobListSubPage(this.vm, this.viewInfo, this.acceptjob, this.deliveredJob, this.pickupDirection, this.deliveryDirection);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return tabbedMenu(context);
  }
  Widget tabbedMenu(BuildContext context){
    return Scaffold(
      appBar:new AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        bottom: new TabBar(
          controller: vm.tabController,
          tabs: [
                          Tab(text: "Jobs("+vm.joblist.length.toString()+")"),
                          Tab(text: "Completed"),
                          Tab(text: "Current"),
          ],
        ),
        ),
        body:TabBarView(
                          controller:vm.tabController,
                          children: [
                          Container(child:jobsListTab(context)),
                          Container(child: completedTab(context)),
                          Container(child:currentDeliveryInfo(context))
      ]));
  }

  Widget jobsListTab(BuildContext context){
    return this.getTransactionsList(context, vm.joblist, (index){
      //TODO: btn click accept job
      print("Accept job");
      print(vm.joblist[index].transaction_code);
      this.acceptjob(vm.joblist[index].transaction_code);
    });
  }
  Widget completedTab(BuildContext context){
    return this.getTransactionsList(context, vm.completedDel, (index){
        //TODO: btn click
    });
  }
  Widget currentDeliveryInfo(BuildContext context){
    return vm.currentDeliveryInfo != null ? Container(
      padding:EdgeInsets.all(20),
      child: Column(children:[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
        Text("Store: "+vm.currentDeliveryInfo.details.store_name, style:TextStyleUtil.textBold(fontSz:10, tColor:Colors.grey)),
        SizedBox(height:10),
        Row(children:[
          Icon(Icons.location_on, size:15, color:Colors.grey),
          SizedBox(width:10),
          Container(
            width:MediaQuery.of(context).size.width-65,
            child:Text("Pickup: "+vm.currentDeliveryInfo.details.store_address, style:TextStyleUtil.textBold(fontSz:10, tColor:Colors.grey)))
        ]),
        SizedBox(height:20),
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
        Text("Name: "+vm.currentDeliveryInfo.details.customer_name, style:TextStyleUtil.textBold(fontSz:9, tColor:Colors.grey)),
        Text("# "+vm.currentDeliveryInfo.details.customer_mobile, style:TextStyleUtil.textBold(fontSz:9, tColor:Colors.grey)),
        ]),
        SizedBox(height:10),
        Row(children:[
          Icon(Icons.location_on, size:15, color:Colors.grey),
          SizedBox(width:10),
          Container(
            width:MediaQuery.of(context).size.width-65,
            child:Text("Deliver: "+vm.currentDeliveryInfo.details.store_address, style:TextStyleUtil.textBold(fontSz:10, tColor:Colors.grey)))
        ]),
      ]),
      SizedBox(height:20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
        Container(
          // width:MediaQuery.of(context).size.width-250,
          child:Text(vm.currentDeliveryInfo.products.length.toString()+" Items", style:TextStyleUtil.textBold(fontSz:9, tColor:Colors.grey))),
          Column(children:[
            buttonWidget("INFO", (){
              this.viewInfo(vm.currentDeliveryInfo.details.transaction_code);
            }, width:120),
            SizedBox(height:5),
            buttonWidget("DELIVERED", (){
              deliveredJob(vm.currentDeliveryInfo.details.transaction_code);
            }, width:120),
            SizedBox(height:5),
            buttonWidget("CANCELLED", (){
              this.pickupDirection(vm.currentDeliveryInfo.details.transaction_code);
            }, width:120),
            SizedBox(height:5),
            buttonWidget("PICKUP DIRECTION", (){
              this.pickupDirection(vm.currentDeliveryInfo.details.transaction_code);
            }, width:150),
            SizedBox(height:5),
            buttonWidget("DELIVERY DIRECTION", (){
              this.deliveryDirection(vm.currentDeliveryInfo.details.transaction_code);
            }, width:150),
          ])
      ]),
    ])) : Container(child:Text("No Delivery In Progress"));
  }

  Widget getTransactionsList(BuildContext context, List<RiderDelivery> transactions, GetIntData click){
    return transactions.length <= 0 ? CircularLoadingWidget(height: 0)  : Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height-100,
      child: SafeArea(
        child: SectionTableView(
          sectionCount: 1,
          numOfRowInSection: (section) {
            return transactions.length;
          },
          cellAtIndexPath: (section, row) {
            var item = transactions[row];
            return transactionCell(context,item, (){
              click(row);
            });
          },
        ),
      ),
    );
  }
  Widget transactionCell(BuildContext context, RiderDelivery item, NormalCallback click){
    return Card(child: Container(
      padding:EdgeInsets.all(20),
      child: Column(children:[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
        Text("Store: "+item.store_name, style:TextStyleUtil.textBold(fontSz:10, tColor:Colors.grey)),
        SizedBox(height:10),
        Container(
          width:MediaQuery.of(context).size.width,
          child:Divider(height:1, thickness: 1, color:Colors.grey)
        ),
        Row(children:[
          Icon(Icons.location_on, size:15, color:Colors.grey),
          SizedBox(width:10),
          Container(
            width:MediaQuery.of(context).size.width-80,
            child:Text("Pickup: "+item.store_address, style:TextStyleUtil.textBold(fontSz:10, tColor:Colors.grey)))
        ]),
        SizedBox(height:20),
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
        Text("Name: "+item.customer_name, style:TextStyleUtil.textBold(fontSz:9, tColor:Colors.grey)),
        Text("# "+item.customer_mobile, style:TextStyleUtil.textBold(fontSz:9, tColor:Colors.grey)),
        ]),
        SizedBox(height:10),
        Container(
          width:MediaQuery.of(context).size.width,
          child:Divider(height:1, thickness: 1, color:Colors.grey)
        ),
        Row(children:[
          Icon(Icons.location_on, size:15, color:Colors.grey),
          SizedBox(width:10),
          Container(
            width:MediaQuery.of(context).size.width-80,
            child:Text("Deliver: "+item.customer_address, style:TextStyleUtil.textBold(fontSz:10, tColor:Colors.grey)))
        ]),
      ]),
      SizedBox(height:20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
        Container(
          child:Text(item.products.toString()+" Items", style:TextStyleUtil.textBold(fontSz:9, tColor:Colors.grey))),
          button(item, click, (){
            this.viewInfo(item.transaction_code);
          })
      ]),
    ])));
  }

  Widget button(RiderDelivery info, NormalCallback click, NormalCallback viewInfo){
    if(info.status == "for pickup"){
      return Row(children:[
        buttonWidget("ACCEPT", click, width:100),
        buttonWidget("INFO", viewInfo),
      ]) ;
    }else{
      return buttonWidget("INFO", viewInfo);
    }
  }

  Widget buttonWidget(String title, NormalCallback click, {double width = 80, double height = 50}){
    return WidgetUI.instance.buttonWidget(title, click, width:width, height:height);
  }


}

class JobListSubPageVM{
  List<RiderDelivery> joblist = [];
  List<RiderDelivery> completedDel = [];
  RiderCurrentDeliveryInfo currentDeliveryInfo;
  RiderCurrentDelivery currentActiveDelivery;
  TabController tabController;

  JobListSubPageVM(this.joblist,this.completedDel, this.currentDeliveryInfo, this.currentActiveDelivery, this.tabController);
}