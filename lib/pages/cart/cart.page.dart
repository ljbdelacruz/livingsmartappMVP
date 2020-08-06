





import 'package:clean_data/base/architechture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';
import 'package:foody_ui/components/carditem/carditem.widget.dart';
import 'package:foody_ui/subui/card.subui.dart';
import 'package:foody_ui/subui/tableviewcells.subui.dart';
import 'package:foody_ui/typdef/mytypedef.dart';
import 'package:livingsmart_app/config/constants.dart';
import 'package:livingsmart_app/services/color.service.dart';
import 'package:livingsmart_app/services/navigator.service.dart';
import 'cart.presenter.dart';
import 'package:foody_ui/components/carditem/carditem1.widget.dart';

class CartPage extends CleanPage {

  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends CleanPageState<CartPresenter> {
  @override
  CartPresenter createPresenter() {
    // TODO: implement createPresenter
    return CartPresenter(this);
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
          "Cart",
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

        ],
      ),
      body: presenter.storeCarts.length > 0 ? cartStoreList() : Text("No Items Available"),
    );

  }

  Widget cartStoreList(){
    List<Widget> items = [];
    presenter.storeCarts.asMap().forEach((index,element) { 
      // items.add(Text(element.name));
      items.add(cartStoreItem(CardItem1WidgetVM("cartstore"+element.id.toString(), element.id.toString(), image:element.image != "" ? Constants.instance.baseURL+element.image : "", quantity: 0, name:element.name, bgColor: Colors.white), (){
        //navigate to store cart items
        print(element.name);
        Constants.instance.cartItemHeader=element.name;
        Constants.instance.cartStoreId=element.id;
        NavigatorService.instance.toCartItem(context);
      }, (){
        //remove store
        presenter.removeStoreCart(index, element.id);
      }));
    });
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height-200,
      child: SafeArea(
        child: Column(children:items),
      ),
    );
  }
  Widget cartStoreItem(CardItem1WidgetVM vm, NormalCallback click, NormalCallback removeStore){
    return TableViewCellsSubUI.instance.heroWidget(context, vm.tag, 
    CardSubUI.instance.dUICard(context, CardItem1Widget(vm, removeStore, click)));
  }


}