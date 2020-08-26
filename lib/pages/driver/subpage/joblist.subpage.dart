


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
    return vm.currentDeliveryInfo == null ? Container(child:Text("No Delivery In Progress")) : 
    Container(child:Column(children:[
      SizedBox(height:20),
      Container(
        decoration: BoxDecoration(
                border: Border.all(color:Colors.grey),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                color: Colors.transparent,
        ),
        padding:EdgeInsets.only(left:10, right:10, top:20, bottom:20),
        width:MediaQuery.of(context).size.width-40,
        child:Row(children:[
          Icon(Icons.pin_drop, size:20, color:Colors.grey),
          SizedBox(width:20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
            Text("PICK UP:", style:TextStyleUtil.textBold(fontSz:15, tColor: Colors.grey)),
            Container(
              child:Text(vm.currentDeliveryInfo.details.store_name)),
            Container(
              width:MediaQuery.of(context).size.width-120,
              child:Text(vm.currentDeliveryInfo.details.store_address)),
            directionButton((){
              this.pickupDirection(vm.currentDeliveryInfo.details.transaction_code);
            }),
            buttonWidget("INFO", (){
              this.viewInfo(vm.currentDeliveryInfo.details.transaction_code);
            }, width:120)
          ])
        ])
      ),
      Container(
        padding:EdgeInsets.only(left:10, right:10, top:20, bottom:20),
        width:MediaQuery.of(context).size.width-40,
        decoration: BoxDecoration(
                border: Border.all(color:Colors.grey),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                color: Colors.transparent,
        ),
        child:Row(children:[
          Icon(Icons.pin_drop, size:20, color:Colors.grey),
          SizedBox(width:20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
            Text("DELIVERY:", style:TextStyleUtil.textBold(fontSz:15, tColor: Colors.grey)),
            Container(
              child:Text(vm.currentDeliveryInfo.details.customer_name)),
            Container(
              width:MediaQuery.of(context).size.width-120,
              child:Text(vm.currentDeliveryInfo.details.customer_address)),
            directionButton((){
              this.deliveryDirection(vm.currentDeliveryInfo.details.transaction_code);
            }),
            buttonWidget("DELIVERED", (){
              deliveredJob(vm.currentDeliveryInfo.details.transaction_code);
            }, width:120),
            buttonWidget("CANCELLED", (){
              this.pickupDirection(vm.currentDeliveryInfo.details.transaction_code);
            }, width:120),
          ]),
        ])
      )
    ]));


  }

  Widget directionButton(NormalCallback click){
    return FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: click,
                        child: Icon(Icons.directions, color: Colors.white),
                        color: ColorsService.instance.primaryColor(),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      );
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