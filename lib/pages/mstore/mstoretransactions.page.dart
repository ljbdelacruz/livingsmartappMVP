




import 'package:clean_data/base/architechture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';
import 'package:foody_ui/components/header/tabbed1.header.dart';
import 'package:foody_ui/components/progress/circularloading.progress.dart';
import 'package:foody_ui/typdef/mytypedef.dart';
import 'package:foody_ui/util/text_style_util.dart';
import 'package:livingsmart_app/config/constants.dart';
import 'package:livingsmart_app/pages/mstore/mstoretransaction.presenter.dart';
import 'package:clean_data/model/transactions.dart';
import 'package:livingsmart_app/services/navigator.service.dart';

class MStoreTransactionsPage extends CleanPage {
  @override
  MStoreTransactionsPageState createState() => MStoreTransactionsPageState();
}

class MStoreTransactionsPageState extends CleanPageState<MStoreTransactionPresenter> {
  
  @override
  MStoreTransactionPresenter createPresenter() {
    return MStoreTransactionPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(child:Scaffold(
      key:presenter.scaffoldKey,
      appBar:AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Transactions",
          style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
      )),
      body:Container(
        height:MediaQuery.of(context).size.height-96,
        child:Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
        tabbedOptions(),
      ]))
    ));
  }

  Widget getTransactionsList(List<MStoreTransaction> transactions){
    return presenter.transactions.length <= 0 ? CircularLoadingWidget(height: 0)  : Container(
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
            return transactionCell(item);
          },
          divider: Container(
            color: Colors.grey,
            height: 1.0,
          ),
        ),
      ),
    );
  }
  Widget buttonCells(MStoreTransaction item){
    if(item.status == "pending"){
      return Column(children:[
         buttonUI("ACCEPT", (){
            //accept request
            presenter.acceptTransaction(item.transaction_code);
         }),
         buttonUI("CANCEL", (){
            //cancel request
            NavigatorService.instance.toMStoreCancelOrderPR(context, (reason) {
              presenter.cancelTransaction(item.transaction_code, reason);
            });
         })
      ]);
    }else if(item.status == "processing"){
      return buttonUI("PICKUP", (){
        //for pickup request
        presenter.readyForPickup(item.transaction_code);
      });
    }else{
      return Container();
    }
  }
  Widget buttonUI(String lbl, NormalCallback click){
    return OutlineButton(onPressed: click,child:Text(lbl));
  }

  Widget transactionCell(MStoreTransaction item){
    return GestureDetector(onTap:(){
      Constants.instance.selectedTransaction=item;
      NavigatorService.instance.toMStoreTransactionInfo(context);
    }, child: Container(
      padding:EdgeInsets.all(20),
      child: Column(children:[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
        Container(
          width:MediaQuery.of(context).size.width-200,
          child:Text(item.customer_address, style:TextStyleUtil.textBold(fontSz:12, tColor:Colors.grey))),
      ]),
      SizedBox(height:10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
        Text(item.customer_name, style:TextStyleUtil.textBold(fontSz:9, tColor:Colors.grey)),
        Text(item.customer_mobile, style:TextStyleUtil.textBold(fontSz:9, tColor:Colors.grey)),
      ]),
      SizedBox(height:20),
      Container(
        width:MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
         Text(item.products.toString()+" Items", style:TextStyleUtil.textBold(fontSz:9, tColor:Colors.grey)),
         buttonCells(item),
        ]))
    ])));
  }

  Widget pendingTab(){
    return getTransactionsList(
      presenter.filterByStatus("pending"));
  }
  Widget processingTab(){
    return getTransactionsList(presenter.filterByStatus("processing"));
  }
  Widget forPickupTab(){
    return getTransactionsList(presenter.filterByStatus("for pickup"));
  }
  Widget forDeliveryTab(){
    return getTransactionsList(presenter.filterByStatus("for delivery"));
  }
  Widget deliveredTab(){
    return getTransactionsList(presenter.filterByStatus("delivered"));
  }
  Widget cancelledTab(){
    return getTransactionsList(presenter.filterByStatus("cancelled"));
  }

  Widget tabbedOptions(){
    return Container(
      // color:Colors.red,
      width:MediaQuery.of(context).size.width,
      height:MediaQuery.of(context).size.height-96,
      child:tabbedMenu());
  }
  Widget tabbedMenu(){
    int pending=presenter.getTransactionCount("pending");
    int processing=presenter.getTransactionCount("processing");
    int forPickup=presenter.getTransactionCount("for pickup");
    int forDelivery=presenter.getTransactionCount("for delivery");
    int delivered=presenter.getTransactionCount("delivered");
    int cancelled=presenter.getTransactionCount("cancelled");
    return DefaultTabController(
                        length: 6,
                        // color:Colors.white,
                        child: Scaffold(
                        appBar: PreferredSize(child: Tabbed1Header(Tabbed1HeaderVM("", [
                                  Tab(text: pending > 0 ?  "Pending("+pending.toString()+")" : "Pending"),
                                  Tab(text: processing > 0 ? "Processing("+processing.toString()+")" : "Processing"),
                                  Tab(text: forPickup > 0 ? "For Pickup("+forPickup.toString()+")" : "For Pickup"),
                                  Tab(text: forDelivery > 0 ? "For Delivery("+forDelivery.toString()+")" : "For Delivery"),
                                  Tab(text: delivered > 0 ? "Delivered("+delivered.toString()+")" : "Delivered"),
                                  Tab(text: cancelled > 0 ? "Cancelled("+cancelled.toString()+")" : "Cancelled"),
                              ])), preferredSize: Size.fromHeight(100)),
                        backgroundColor: Colors.transparent,
                        body:TabBarView(children: [
                          Container(
                            height:MediaQuery.of(context).size.height-150,
                            child:pendingTab()),
                          Container(child:processingTab()),
                          Container(child:forPickupTab()),
                          Container(child:forDeliveryTab()),
                          Container(child:deliveredTab()),
                          Container(child:cancelledTab())
                        ],)
                      ),
        );
  }


}