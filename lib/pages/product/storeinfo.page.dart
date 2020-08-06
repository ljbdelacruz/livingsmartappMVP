






import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_data/base/architechture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:foody_ui/components/progress/circularloading.progress.dart';
import 'package:foody_ui/services/color.service.dart';
import 'package:foody_ui/subui/tabs.subui.dart';
import 'package:foody_ui/util/text_style_util.dart';
import 'package:livingsmart_app/config/constants.dart';
import 'package:livingsmart_app/pages/product/storeinfo.presenter.dart';
import 'package:foody_ui/components/progress/foodloader.progress.dart';
import 'package:foody_ui/components/cells/fooditemwidget.cells.dart';
import 'package:livingsmart_app/services/navigator.service.dart';


class StoreInfoPage extends CleanPage {

  @override
  StoreInfoPageState createState() => StoreInfoPageState();
}

class StoreInfoPageState extends CleanPageState<StoreInfoPresenter> with SingleTickerProviderStateMixin{
  
  @override
  StoreInfoPresenter createPresenter() {
    // TODO: implement createPresenters
    return StoreInfoPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(presenter.storeInfo == null){
      return CircularLoadingWidget(height: 500);
    }else{
      return SafeArea(child: Scaffold(
        key:presenter.scaffoldKey,
        appBar:AppBar(
          backgroundColor: ColorsService.dirtyWhite(),
          elevation: 0,
          centerTitle: true,
          title: Text(
            presenter.storeInfo != null ? presenter.storeInfo.store_info.name : "",
            style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
          )
        ),
        body: SingleChildScrollView(child: bodyWidget())
      ));
    }
  }
  Widget bodyWidget(){
    return Container(child:Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
          CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                  height:200,
                                  imageUrl: presenter.storeInfo.store_info.image != "null" ? Constants.instance.baseURL+presenter.storeInfo.store_info.image : Constants.instance.noImageDefault,
                                  placeholder: (context, url) => Image.asset(
                                    'assets/images/loader/loading.gif',
                                    fit: BoxFit.cover,
                                  ),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Container(
            padding:EdgeInsets.only(left:30, top: 20),
            child: Text(presenter.storeInfo.store_info.name, style:TextStyleUtil.textBold(fontSz:20, tColor: Colors.grey))),
          Container(
            padding:EdgeInsets.only(left:30, top: 12),
            child: Text(presenter.storeInfo.store_info.description, style:TextStyleUtil.textNormal(fontSz:12, tColor: Colors.grey))),
          Container(
            padding:EdgeInsets.only(left:30, top: 12),
            child: Text("Address:", style:TextStyleUtil.textBold(fontSz:15, tColor: Colors.grey))),
          Container(
            padding:EdgeInsets.only(left:30, top: 0, bottom:20),
            child: Text(presenter.storeInfo.store_info.address, style:TextStyleUtil.textNormal(fontSz:12, tColor: Colors.grey))),
          Divider(thickness: 2,),
          Container(
            padding:EdgeInsets.only(left:30, top: 12),
            child: Text("Contact Number:", style:TextStyleUtil.textBold(fontSz:15, tColor: Colors.grey))),
          Container(
            padding:EdgeInsets.only(left:30, top: 0, ),
            child: Text(presenter.storeInfo.store_info.mobile, style:TextStyleUtil.textNormal(fontSz:12, tColor: Colors.grey))),
          Container(
            padding:EdgeInsets.only(left:30, top: 0, bottom:20),
            child: Text(presenter.storeInfo.store_info.phone, style:TextStyleUtil.textNormal(fontSz:12, tColor: Colors.grey))),
          Divider(thickness: 2,),
          tabs(),
          Container(
            width:MediaQuery.of(context).size.width,
            height:400,
            child:tabContent()
          )
      ]));
  }
  Widget tabs(){
    return TabsSubUI.instance.wUITabs(["Shop", "Products"], presenter.tabController, lblColor:Colors.black, usColor: Colors.black, indiColor: Colors.black);
  }
  Widget tabContent(){
    return TabBarView(
                      controller: presenter.tabController,
                      children:[
                      Container(),
                      productList(),
    ]);
  }

  Widget productList(){
    // List<Widget> items = [];
    // presenter.storeInfo.products.forEach((element) { 

    // });
    return presenter.storeInfo.products.isEmpty
        ? FoodsCarouselLoaderWidget("assets/images/loader/loading_trend.gif")
        : Container(
            height: 210,
            // color: Theme.of(context).primaryColor,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
              itemCount: presenter.storeInfo.products.length,
              itemBuilder: (context, index) {
                double _marginLeft = 0;
                (index == 0) ? _marginLeft = 20 : _marginLeft = 0;
                return FoodsCarouselItemWidget(
                  FoodsCarouselItemWidgetVM(name:presenter.storeInfo.products[index].name, 
                                            restName:presenter.storeInfo.store_info.name,
                                            image:presenter.storeInfo.products[index].image != null ? Constants.instance.baseURL+ presenter.storeInfo.products[index].image : Constants.instance.noImageDefault,
                                            price:presenter.storeInfo.products[index].price
                                           ),(){
                                             //Selected Product
                                             Constants.instance.selectedProdId=presenter.storeInfo.products[index].id;
                                             Constants.instance.selectedStoreId=presenter.storeInfo.store_info.id;
                                             NavigatorService.instance.toProductInfo(context);
                                           }
                );
              },
              scrollDirection: Axis.horizontal,
            ));
  }

}