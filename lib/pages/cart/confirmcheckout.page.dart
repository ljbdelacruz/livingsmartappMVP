



import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_data/base/architechture.dart';
import 'package:clean_data/model/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foody_ui/components/progress/circularloading.progress.dart';
import 'package:foody_ui/util/text_style_util.dart';
import 'package:livingsmart_app/config/constants.dart';
import 'package:livingsmart_app/pages/cart/cart.presenter.dart';
import 'package:livingsmart_app/services/pickermodal.service.dart';


class ConfirmCheckoutPage extends CleanPage {

  @override
  ConfirmCheckoutPageState createState() => ConfirmCheckoutPageState();
}

class ConfirmCheckoutPageState extends CleanPageState<CartPresenter> {
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
          "Confirm Checkout",
          style: TextStyleUtil.textBold(fontSz:12),
        )
      ),
      body:SingleChildScrollView(child:Column(children:[
        SizedBox(height:30),
        this.storeInfo(),
        SizedBox(height:30),
        selectPaymentOption(),
        SizedBox(height:30),
        this.productsList(),
        SizedBox(height:50),
        checkoutBtn(),
      ]))
    ));
  }

  Widget storeInfo(){
    return presenter.selectedStore != null ? Container(
      width: MediaQuery.of(context).size.width,
      padding:EdgeInsets.only(left:30, right:30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
      Text(presenter.selectedStore.name, style:TextStyleUtil.textBold(fontSz:14, tColor: Colors.grey)),
      Text(presenter.selectedStore.address, style:TextStyleUtil.textNormal(fontSz:11, tColor: Colors.grey))
    ])) : CircularLoadingWidget(height:20);
  }

  Widget productsList(){
    List<Widget> items = [];
    presenter.cartStoreItems.forEach((element) { 
      items.add(productCells(element));
    });
    return Container(
      padding:EdgeInsets.only(left:20, right:20),
      child: Column(children:items));
  }

  Widget productCells(CartStoreItem item){
    return Row(children:[
            ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                child: CachedNetworkImage(
                  height: 90,
                  width: 90,
                  fit: BoxFit.cover,
                  imageUrl: item.image != null ? Constants.instance.baseURL+item.image : Constants.instance.noImageDefault,
                  placeholder: (context, url) => Image.asset(
                    "assets/images/loader/loading.gif",
                    fit: BoxFit.cover,
                    height: 90,
                    width: 90,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            SizedBox(width:10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Container(
                  width:MediaQuery.of(context).size.width-140,
                  child: Text(item.name, style:TextStyleUtil.textBold(fontSz:13, tColor: Colors.grey))),
                Text("x"+item.quantity.toString(), style:TextStyleUtil.textNormal(fontSz:12, tColor: Colors.grey)),
            ])
    ]);
  }

  Widget selectPaymentOption(){
    return Container(
      padding:EdgeInsets.only(left:20, right:20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
        Text("Select Payment Method:", style:TextStyleUtil.textBold(fontSz:12, tColor: Colors.grey)),
        OutlineButton(onPressed: (){
          //TODO: picker modal
          PickerModalService.instance.showModal(context, ["Cash On Delivery", "GCash"], (data) { 
            presenter.selectedPaymentMethod=data;
            this.setState(() {});
          });
        }, child: Container(
          width:MediaQuery.of(context).size.width-90,
          child: Text(presenter.selectedPaymentMethod, style:TextStyleUtil.textNormal(fontSz:12, tColor: Colors.grey))))
    ]));
  }

  Widget checkoutBtn(){
    return Container(
      padding:EdgeInsets.only(left:30, right:30),
      child: Column(children:[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
        Text("Delivery Fee: "),
        Text(Constants.instance.currency+presenter.selectedStore.delivery_fee),
      ]),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
          Text(Constants.instance.currency+presenter.calculatePrice().toString(), style:TextStyleUtil.textBold(fontSz:15)),
          OutlineButton(onPressed:(){
            presenter.checkout();
          }, child: Text("CHECKOUT", style:TextStyleUtil.textNormal(fontSz:12)))
      ])
    ]));
  }

}