




import 'package:clean_data/base/architechture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foody_ui/util/text_style_util.dart';
import 'package:livingsmart_app/config/constants.dart';
import 'package:livingsmart_app/pages/cart/cart.presenter.dart';
import 'package:foody_ui/components/carditem/cartitem2.widget.dart';
import 'package:livingsmart_app/services/navigator.service.dart';

class CartItemPage extends CleanPage {
  @override
  CartItemPageState createState() => CartItemPageState();
}

class CartItemPageState extends CleanPageState<CartPresenter> {
  @override
  CartPresenter createPresenter() {
    // TODO: implement createPresenter
    return CartPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(child: Scaffold(
      key:presenter.scaffoldKey,
      appBar:AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          presenter.cartItemHeader,
          style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
        )
      ),
      body:Center(child: presenter.cartStoreItems.length <= 0 ? Text("No Cart Items") : cartItems()),
      bottomNavigationBar: bottomNav(),
      ));
  }
  Widget cartItems(){
    List<Widget> items = [];
    presenter.cartStoreItems.asMap().forEach((index, element) { 
      items.add(CardItem2Widget(CardItem2WidgetVM("item"+element.id.toString(), element.id.toString(), image:Constants.instance.baseURL+element.image, quantity: element.quantity, name:element.name), (){
        //TODO: remove item
        presenter.removeCartStoreItem(element.id, index);
      }, (){
        //TODO: click item
        Constants.instance.selectedProdId=element.product_id;
        Constants.instance.selectedStoreId=element.store_id;
        NavigatorService.instance.toProductInfo(context);
      }, (){
        presenter.increment(element);
      }, (){
        presenter.decrement(element);
      }));
    });
    return Column(children:items);
  }
  Widget bottomNav(){
    var price = presenter.calculatePrice();
    return Container(
      width:MediaQuery.of(context).size.width,
      height:70,
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
      Padding(padding:EdgeInsets.only(left:20), child:Text("PHP "+price.toString(), style:TextStyleUtil.textBold(fontSz:20, tColor:Colors.black))),
      checkoutBtn()

    ]));
  }

  Widget checkoutBtn(){
    return Container(
      padding:EdgeInsets.all(20),
      color:Colors.red,
      child:Row(children:[
      Icon(Icons.shopping_cart, size:20, color:Colors.white),
      SizedBox(width:10),
      Text("Checkout", style:TextStyleUtil.textBold(fontSz:15, tColor:Colors.white))
    ]));
  }
}