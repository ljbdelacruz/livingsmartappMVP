



import 'package:clean_data/model/transactions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';
import 'package:foody_ui/components/header/tabbed1.header.dart';
import 'package:foody_ui/components/progress/circularloading.progress.dart';
import 'package:foody_ui/typdef/mytypedef.dart';
import 'package:foody_ui/util/text_style_util.dart';

class UserTransactionsSubPage extends StatelessWidget {
  final UserTransactionsSubPageVM vm;
  final GetStringData transactionInfo;
  UserTransactionsSubPage(this.vm, this.transactionInfo);

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
                        length: 2,
                        // color:Colors.white,
                        child: Scaffold(
                        appBar: PreferredSize(child: Tabbed1Header(Tabbed1HeaderVM("", [
                          Tab(text: "For Delivery("+vm.forDelivery.length.toString()+")"),
                          Tab(text: "Completed"),
                        ])), preferredSize: Size.fromHeight(100)),
                        backgroundColor: Colors.transparent,
                        body:TabBarView(children: [
                          Container(child:forDelivery(context)),
                          Container(child: completed(context)),
                        ])
                      ),
    );
  }

  Widget forDelivery(BuildContext context){
    return getTransactionsList(context, vm.forDelivery, (index){

    });
  }
  Widget completed(BuildContext context){
    return getTransactionsList(context, vm.completed, (index){

    });
  }

  Widget getTransactionsList(BuildContext context, List<UserTransaction> transactions, GetIntData click){
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
  Widget transactionCell(BuildContext context, UserTransaction item, NormalCallback click){
    return Container(
      padding:EdgeInsets.all(20),
      child: Column(children:[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
          Text("Store: "+item.store_name, style:TextStyleUtil.textBold(fontSz:10, tColor:Colors.grey)),
          Text(item.store_mobile, style:TextStyleUtil.textBold(fontSz:10, tColor:Colors.grey)),
        ]),
        SizedBox(height:10),
        Row(children:[
          Icon(Icons.location_on, size:15, color:Colors.grey),
          SizedBox(width:10),
          Container(
            width:MediaQuery.of(context).size.width-65,
            child:Text("Pickup: "+item.store_address, style:TextStyleUtil.textBold(fontSz:10, tColor:Colors.grey)))
        ]),
        SizedBox(height:20),
        Text(item.status.toUpperCase(), style:TextStyleUtil.textNormal(fontSz:9))
      ]),
      SizedBox(height:20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
        Container(
          width:MediaQuery.of(context).size.width-250,
          child:Text(item.products.toString()+" Items", style:TextStyleUtil.textBold(fontSz:9, tColor:Colors.grey))),
          buttons((){
            this.transactionInfo(item.transaction_code);
          })
      ]),
    ]));
  }
  Widget buttons(NormalCallback click){
    return OutlineButton(onPressed: click, child:Text("INFO", style:TextStyleUtil.textBold(fontSz:9)));
  }

}

class UserTransactionsSubPageVM{
  List<UserTransaction> transactions = [];
  List<UserTransaction> completed = [];
  List<UserTransaction> forDelivery = [];
  List<UserTransaction> processing = [];

  UserTransactionsSubPageVM(this.transactions){
    transactions.forEach((element) { 
      if(element.status == "delivered"){
        this.completed.add(element);
      }else if(element.status == "for delivery"){
        this.forDelivery.add(element);
      }
    });
  }
}