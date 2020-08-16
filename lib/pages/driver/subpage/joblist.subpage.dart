


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';
import 'package:foody_ui/components/header/tabbed1.header.dart';
import 'package:clean_data/model/delivery.dart';
import 'package:foody_ui/components/progress/circularloading.progress.dart';
import 'package:foody_ui/typdef/mytypedef.dart';
import 'package:foody_ui/util/text_style_util.dart';

class JobListSubPage extends StatelessWidget {
  final JobListSubPageVM vm;
  final GetStringData viewInfo;
  final GetStringData acceptjob;
  final GetStringData deliveredJob;

  JobListSubPage(this.vm, this.viewInfo, this.acceptjob, this.deliveredJob);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(children:[
      tabbedOptions(context)
    ]);
  }

  Widget tabbedOptions(BuildContext context) {
    return Container(
      // color:Colors.red,
      width:MediaQuery.of(context).size.width,
      height:MediaQuery.of(context).size.height/2,
      child:tabbedMenu(context));
  }
  Widget tabbedMenu(BuildContext context){
    return DefaultTabController(
                        length: 3,
                        // color:Colors.white,
                        child: Scaffold(
                        appBar: PreferredSize(child: Tabbed1Header(Tabbed1HeaderVM("", [
                          Tab(text: "Jobs("+vm.joblist.length.toString()+")"),
                          Tab(text: "Completed"),
                          Tab(text: "Current"),
                        ])), preferredSize: Size.fromHeight(100)),
                        backgroundColor: Colors.transparent,
                        body:TabBarView(children: [
                          Container(child:jobsListTab(context)),
                          Container(child: completedTab(context)),
                          Container(child:currentDeliveryInfo(context))
                        ])
                      ),
    );
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
          OutlineButton(onPressed:(){
            this.viewInfo(vm.currentDeliveryInfo.details.transaction_code);
          }, child: Text("INFO", style:TextStyleUtil.textNormal(fontSz:8))),
          OutlineButton(onPressed:(){
            deliveredJob(vm.currentDeliveryInfo.details.transaction_code);
          }, child: Text("DELIVERED", style:TextStyleUtil.textNormal(fontSz:8))),
          OutlineButton(onPressed:(){
          }, child: Text("CANCELLED", style:TextStyleUtil.textNormal(fontSz:8))),
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
          divider: Container(
            color: Colors.grey,
            height: 1.0,
          ),
        ),
      ),
    );
  }
  Widget transactionCell(BuildContext context, RiderDelivery item, NormalCallback click){
    return Container(
      padding:EdgeInsets.all(20),
      child: Column(children:[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
        Text("Store: "+item.store_name, style:TextStyleUtil.textBold(fontSz:10, tColor:Colors.grey)),
        SizedBox(height:10),
        Row(children:[
          Icon(Icons.location_on, size:15, color:Colors.grey),
          SizedBox(width:10),
          Container(
            width:MediaQuery.of(context).size.width-65,
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
        Row(children:[
          Icon(Icons.location_on, size:15, color:Colors.grey),
          SizedBox(width:10),
          Container(
            width:MediaQuery.of(context).size.width-65,
            child:Text("Deliver: "+item.customer_address, style:TextStyleUtil.textBold(fontSz:10, tColor:Colors.grey)))
        ]),
      ]),
      SizedBox(height:20),
      Row(children:[
        Container(
          width:MediaQuery.of(context).size.width-250,
          child:Text(item.products.toString()+" Items", style:TextStyleUtil.textBold(fontSz:9, tColor:Colors.grey))),
          button(item, click, (){
            print("Event Clicked");
            this.viewInfo(item.transaction_code);
          })
      ]),
    ]));
  }

  Widget button(RiderDelivery info, NormalCallback click, NormalCallback viewInfo){
    if(info.status == "for pickup"){
      return Row(children:[
        OutlineButton(onPressed:click, child: Text("ACCEPT", style:TextStyleUtil.textNormal(fontSz:11))),
        OutlineButton(onPressed:viewInfo, child: Text("INFO", style:TextStyleUtil.textNormal(fontSz:11))),
      ]) ;
    }else{
      return OutlineButton(onPressed:viewInfo, child: Text("INFO", style:TextStyleUtil.textNormal(fontSz:11)));
    }
  }


}

class JobListSubPageVM{
  List<RiderDelivery> joblist = [];
  List<RiderDelivery> completedDel = [];
  RiderCurrentDeliveryInfo currentDeliveryInfo;
  RiderCurrentDelivery currentActiveDelivery;
  JobListSubPageVM(this.joblist,this.completedDel, this.currentDeliveryInfo, this.currentActiveDelivery);
}