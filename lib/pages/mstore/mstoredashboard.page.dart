







import 'package:clean_data/base/architechture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';
import 'package:foody_ui/components/header/tabbed1.header.dart';
import 'package:foody_ui/util/text_style_util.dart';
import 'package:livingsmart_app/config/constants.dart';
import 'package:livingsmart_app/pages/mstore/mstoredashboard.presenter.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:livingsmart_app/services/navigator.service.dart';
import 'package:foody_ui/components/cells/fooditem1widget.cells.dart';


class MStoreDashboardPage extends CleanPage {
  @override
  MStoreDashboardPageState createState() => MStoreDashboardPageState();
}

class MStoreDashboardPageState extends CleanPageState<MStoreDashboardPresenter> {
  @override
  MStoreDashboardPresenter createPresenter() {
    return MStoreDashboardPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        key:presenter.scaffoldKey,
        appBar:AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "MStore",
          style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Theme.of(context).hintColor,
            ),
            onPressed: () {
              // NavigatorService.instance.mstoreNotification(context);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.linear_scale,
              color: Theme.of(context).hintColor,
            ),
            onPressed: () {
              NavigatorService.instance.toMStoreTransactions(context);
              // NavigatorService.instance.mstoreNotification(context);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.list,
              color: Theme.of(context).hintColor,
            ),
            onPressed: () {
              NavigatorService.instance.toMStoreProducts(context);
            },
          ),

        ],
      ),
      body:Container(child:Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
        Container(
          padding:EdgeInsets.only(left:15),
          child:Text(presenter.storeName, style:TextStyleUtil.textNormal(fontSz:20, tColor:Colors.grey))),
        tabbedOptions(),
        transactionHist(),
      ]))
    );
  }

  Widget tabbedOptions(){
    return Container(
      // color:Colors.red,
      width:MediaQuery.of(context).size.width,
      height:MediaQuery.of(context).size.height/2,
      child:tabbedMenu());
  }
  Widget transactionHist(){
    return Container(
        // color:Colors.blue,
        width:MediaQuery.of(context).size.width,
        height:(MediaQuery.of(context).size.height/2)-152,
        child:SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:Column(children:[
          Text("Transaction History"),
          transactionCells()
        ]))
    );
  }
  Widget tabbedMenu(){
    return DefaultTabController(
                        length: 2,
                        // color:Colors.white,
                        child: Scaffold(
                        appBar: PreferredSize(child: Tabbed1Header(Tabbed1HeaderVM("", [
                                  Tab(text: "Sales"),
                                  Tab(text: "Inventory"),
                                  // Tab(text: "Acitivities"),
                                  // Tab(text: "Subscription"),
                              ])), preferredSize: Size.fromHeight(100)),
                        backgroundColor: Colors.transparent,
                        body:TabBarView(children: [
                          Container(child:salesTab()),
                          Container(child:inventoryTab()),
                          // exploreTab(),
                          // shops(),
                          // activity(),
                          // subscription(),
                        ],)
                      ),
        );
  }
  Widget salesTab(){
    return SingleChildScrollView(child:Column(children:[
      graphSales(),
      legendsUI(),
    ]));
  }

  Widget graphSales(){
      var series = [
      charts.Series(
        id: "Successful Sales",
        domainFn: (TransactionPerEntry data, _) => data.label,
        measureFn: (TransactionPerEntry data, _) => data.data,
        colorFn: (TransactionPerEntry data, _) => data.color,
        data: presenter.sucessfulTransactions
      ),
      charts.Series(
        id: "Failed",
        domainFn: (TransactionPerEntry data, _) => data.label,
        measureFn: (TransactionPerEntry data, _) => data.data,
        colorFn: (TransactionPerEntry data, _) => data.color,
        data: presenter.failedTransactions,
      ),
    ];
    var chart=charts.BarChart(series, animate: true);
    return Container(
      child:SizedBox(
        height: 200.0,
        child: chart,
    ));
  }
    Widget legendsUI(){
      return Container(
        padding:EdgeInsets.only(left:20, right:20, top:10),
        child:Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        Padding(padding:EdgeInsets.only(top:10), child:legendInfo("Successful Transactions", Color(0xffFFA028))),
        Padding(padding:EdgeInsets.only(top:10), child:legendInfo("Failed Transactions", Colors.black),),
      ],));
  }
  Widget legendInfo(String lbl, Color color){
    return Row(children: [
      Container(height:30, width:30, color:color,),
      Padding(padding: EdgeInsets.only(left: 20), child:Text(lbl),)
    ],);
  }


  Widget inventoryTab(){
    if(Constants.instance.mstoreData.products.length > 0){
      return Container(child: SectionTableView(
            sectionCount: 1,
            numOfRowInSection: (section) {
              return Constants.instance.mstoreData.products.length;
            },
            cellAtIndexPath: (section, row) {
              var item = Constants.instance.globalItems[row];
              return FoodItemWidget(FoodItemWidgetVM(name:item.name, price:item.price, currency:Constants.instance.currency, image: item.image != "null" ? Constants.instance.baseURL+item.image : Constants.instance.noImageDefault), (){
                //TODO: request add item
              });
            },
            divider: Container(
              color: Colors.grey,
              height: 1.0,
            ),
      ));
    }else{
      return Container(
        child: Center(child: Text("No Products Available")));
    }
    // return SingleChildScrollView(child:Column(children:[
    //   Text("Inventory Tab"),
    // ]));
  }
  Widget transactionCells(){
    return Column(children:[
      // MStoreSubUI.transactionCell(context, MStoreTransactionCellsVM("1ee", "Lainel John Dela Cruz", "200", "Success"), (){
      //   //TODO: CLicked item
      // }),
      // MStoreSubUI.transactionCell(context, MStoreTransactionCellsVM("2ee", "Maria Ondong", "50", "Pending"), (){
      //   //TODO: CLicked item
      // }),
      // MStoreSubUI.transactionCell(context, MStoreTransactionCellsVM("2ee", "Maria Ondong", "50", "Pending"), (){
      //   //TODO: CLicked item
      // })
    ]);
  }
}


class TransactionPerEntry{
  String label;
  double data;
  charts.Color color;
  TransactionPerEntry(this.label, this.data, this.color);
  //TODO: Weekly
  static TransactionPerEntry dumm1(){
    return TransactionPerEntry("Jan", 34, charts.Color.fromHex(code:"#FFA028"));
  }
  static TransactionPerEntry dumm2(){
    return TransactionPerEntry("Feb", 34, charts.Color.fromHex(code:"#FFA028"));
  }
  static TransactionPerEntry dumm3(){
    return TransactionPerEntry("Mar", 0, charts.Color.fromHex(code:"#FFA028"));
  }
  static TransactionPerEntry dumm4(){
    return TransactionPerEntry("Apr", 0, charts.Color.fromHex(code:"#FFA028"));
  }
  static TransactionPerEntry dumm5(){
    return TransactionPerEntry("May", 140, charts.Color.fromHex(code:"#FFA028"));
  }
  static TransactionPerEntry dumm6(){
    return TransactionPerEntry("Jun", 100, charts.Color.fromHex(code:"#FFA028"));
  }

  static TransactionPerEntry fdumm1(){
    return TransactionPerEntry("Jan", 20, charts.Color.black);
  }
  static TransactionPerEntry fdumm2(){
    return TransactionPerEntry("Feb", 100, charts.Color.black);
  }




}