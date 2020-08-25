



import 'package:clean_data/model/transactions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';
import 'package:foody_ui/components/header/tabbed1.header.dart';
import 'package:foody_ui/components/progress/circularloading.progress.dart';
import 'package:foody_ui/typdef/mytypedef.dart';
import 'package:foody_ui/util/text_style_util.dart';
import 'package:livingsmart_app/config/constants.dart';

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
      height: Constants.instance.isDeliveryInProgress ? MediaQuery.of(context).size.height-282 : MediaQuery.of(context).size.height-250,
      child:tabbedMenu(context));
  }
  Widget tabbedMenu(BuildContext context){
    return DefaultTabController(
                        length: 4,
                        // color:Colors.white,
                        child: Scaffold(
                        appBar: PreferredSize(child: Tabbed1Header(Tabbed1HeaderVM("", [
                          Tab(text: "Pending("+vm.pending.length.toString()+")"),
                          Tab(text: "Processing("+vm.processing.length.toString()+")"),
                          Tab(text: "For Delivery("+vm.forDelivery.length.toString()+")"),
                          Tab(text: "Completed"),
                        ])), preferredSize: Size.fromHeight(100)),
                        backgroundColor: Colors.transparent,
                        body:TabBarView(children: [
                          Container(
                            height:MediaQuery.of(context).size.height-150,
                            child:pending(context)),
                          Container(
                            height:MediaQuery.of(context).size.height-150,
                            child:processing(context)),
                          Container(
                            height:MediaQuery.of(context).size.height-150,
                            child:forDelivery(context)),
                          Container(
                            height:MediaQuery.of(context).size.height-150,
                            child: completed(context)),
                        ])
                      ),
    );
  }
  Widget pending(BuildContext context){
    return getTransactionsList(context, vm.pending, (index){

    });
  }
  Widget processing(BuildContext context){
    return getTransactionsList(context, vm.processing, (index){

    });
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
      height: MediaQuery.of(context).size.height-150,
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
  Widget transactionCell(BuildContext context, UserTransaction item, NormalCallback click){
    return Card(
      // padding:EdgeInsets.all(20),
      child: Column(children:[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
        Padding(padding: EdgeInsets.only(top:10, left:20, right:20), child:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
          Text("Store: "+item.store_name, style:TextStyleUtil.textBold(fontSz:10, tColor:Colors.grey)),
          Text(item.status.toUpperCase(), style:TextStyleUtil.textBold(fontSz:10, tColor:Colors.grey)),
        ])),
        Container(
          width:MediaQuery.of(context).size.width,
          child:Divider(height: 2, thickness:1, color:Colors.grey)
        ),
        SizedBox(height:10),
        Padding(padding: EdgeInsets.only(top:10, left:20, right:20), child:
        Row(children:[
          Icon(Icons.location_on, size:15, color:Colors.grey),
          SizedBox(width:10),
          Container(
            width:MediaQuery.of(context).size.width-80,
            child:Text("Pickup: "+item.store_address, style:TextStyleUtil.textBold(fontSz:10, tColor:Colors.grey)))
        ])),
        SizedBox(height:20),
        Padding(padding: EdgeInsets.only(top:0, left:20, right:20), child:
        Text("#"+item.transaction_code, style:TextStyleUtil.textNormal(fontSz:9)))
      ]),
      Container(
          width:MediaQuery.of(context).size.width,
          child:Divider(height: 2, thickness:1, color:Colors.grey)
      ),
      SizedBox(height:20),
      Padding(padding: EdgeInsets.only(top:0, left:20, right:20), child:
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
        Container(
          width:MediaQuery.of(context).size.width-250,
          child:Text(item.products.toString()+" Items", style:TextStyleUtil.textBold(fontSz:9, tColor:Colors.grey))),
          buttons((){
            this.transactionInfo(item.transaction_code);
          })
      ])),
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
  List<UserTransaction> pending = [];
  List<UserTransaction> processing = [];

  UserTransactionsSubPageVM(this.transactions){
    transactions.forEach((element) { 
      if(element.status == "delivered"){
        this.completed.add(element);
      }else if(element.status == "for delivery"){
        this.forDelivery.add(element);
      }else if(element.status == "pending"){
        this.pending.add(element);
      }else if(element.status == "processing"){
        this.processing.add(element);
      }
    });
  }
}