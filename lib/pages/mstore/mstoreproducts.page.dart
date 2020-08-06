




import 'package:clean_data/base/architechture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';
import 'package:foody_ui/components/header/tabbed1.header.dart';
import 'package:livingsmart_app/config/constants.dart';
import 'package:livingsmart_app/pages/mstore/mstoreproducts.presenter.dart';
import 'package:foody_ui/components/cells/fooditem1widget.cells.dart';

class MStoreProductsPage extends CleanPage {
  @override
  MStoreProductsPageState createState() => MStoreProductsPageState();
}

class MStoreProductsPageState extends CleanPageState<MStoreProductPresenter> {
  @override
  MStoreProductPresenter createPresenter() {
    return MStoreProductPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    //TODO: implement build
    return Scaffold(
        key:presenter.scaffoldKey,
        appBar:AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "MStore Products",
          style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
        ),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(
        //       Icons.notifications,
        //       color: Theme.of(context).hintColor,
        //     ),
        //     onPressed: () {
        //       // NavigatorService.instance.mstoreNotification(context);
        //     },
        //   ),
        // ],
      ),
      body:Container(child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
        tabbedOptions(),
        // inStoreProducts(),
      ]))
    );
  }

   Widget tabbedOptions(){
    return Container(
      // color:Colors.red,
      width:MediaQuery.of(context).size.width,
      height:MediaQuery.of(context).size.height/1.2,
      child:tabbedMenu());
  }
  Widget tabbedMenu(){
    return DefaultTabController(
                        length: 2,
                        // color:Colors.white,
                        child: Scaffold(
                        appBar: PreferredSize(child: Tabbed1Header(Tabbed1HeaderVM("", [
                                  Tab(text: "Request"),
                                  Tab(text: "In Store"),
                              ])), preferredSize: Size.fromHeight(100)),
                        backgroundColor: Colors.transparent,
                        body:TabBarView(children: [
                          Container(child:globalProducts()),
                          Container(child:inStoreProducts()),
                        ],)
                      ),
        );
  }

  Widget globalProducts(){
    List<Widget> items = [];
    Constants.instance.globalItems.forEach((element) { 
      items.add(productItem(true, title:element.name));
    });
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height-200,
      child: SafeArea(
        child: SectionTableView(
          sectionCount: 1,
          numOfRowInSection: (section) {
            return Constants.instance.globalItems.length;
          },
          cellAtIndexPath: (section, row) {
            var item = Constants.instance.globalItems[row];
            return FoodItemWidget(FoodItemWidgetVM(name:item.name, price:item.price, currency:Constants.instance.currency, image: item.image != "null" ? Constants.instance.baseURL+item.image : Constants.instance.noImageDefault), (){
              //TODO: request add item
              print("Requesting products");
              presenter.requestProductAdd(item.id);
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
  Widget inStoreProducts(){
    return Container(child: SectionTableView(
            sectionCount: 1,
            numOfRowInSection: (section) {
              return Constants.instance.mstoreData.products.length;
            },
            cellAtIndexPath: (section, row) {
              var item = Constants.instance.globalItems[row];
              return FoodItemWidget(FoodItemWidgetVM(name:item.name, price:item.price, currency:Constants.instance.currency, image: item.image != "null" ? Constants.instance.baseURL+item.image : Constants.instance.noImageDefault), (){
                //TODO: 
              });
            },
            divider: Container(
              color: Colors.grey,
              height: 1.0,
            ),
      ));
  }

  Widget productItem(bool isRequested, {String title = ""}){
    return Container(child:Column(children:[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
        Text(title),
        Text("Request")
      ])
    ]));
  }


}