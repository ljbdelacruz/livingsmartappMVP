








import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_data/base/architechture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:foody_ui/util/text_style_util.dart';
import 'package:livingsmart_app/config/constants.dart';
import 'package:livingsmart_app/pages/product/productinfo.presenter.dart';
import 'package:foody_ui/components/progress/circularloading.progress.dart';

class ProductInfoPage extends CleanPage {

  @override
  ProductInfoPageState createState() => ProductInfoPageState();
}

class ProductInfoPageState extends CleanPageState<ProductInfoPresenter> {
  @override
  ProductInfoPresenter createPresenter() {
    // TODO: implement createPresenter
    return ProductInfoPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(child: Scaffold(
      key: presenter.scaffoldKey,
      appBar:AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          presenter.selectedProd != null ? presenter.selectedProd.name : "",
          style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
        )
      ),
      body: body2(),
      bottomNavigationBar: bottomNav(),
                    ));
  }

  Widget body2(){
    if(presenter.selectedStore != null && presenter.selectedProd != null){
      return SingleChildScrollView(child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
        CachedNetworkImage(
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                                height:200,
                                imageUrl: Constants.instance.baseURL+presenter.selectedProd.image,
                                placeholder: (context, url) => Image.asset(
                                  'assets/images/loader/loading.gif',
                                  fit: BoxFit.cover,
                                ),
                                errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          padding:EdgeInsets.only(left:30, top: 20),
          child: Text(presenter.selectedProd.name, style:TextStyleUtil.textBold(fontSz:20, tColor: Colors.grey))),
        Container(
          padding:EdgeInsets.only(left:30, top:10),
          child: Text(presenter.selectedStore.store_info.name, style:TextStyleUtil.textBold(fontSz:15, tColor: Colors.grey))),
        Container(
          padding:EdgeInsets.only(left:30, top:10),
          child: Text(presenter.selectedProd.description, style:TextStyleUtil.textBold(fontSz:12, tColor: Colors.grey))),
      ]));
    }else{
      return CircularLoadingWidget(height: 500);
    }
  }

  Widget bottomNav(){
    if(presenter.selectedProd != null){

    if(presenter.selectedProd.stock_count <= 0){
      return Container(
        width:MediaQuery.of(context).size.width,
        height:150,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        boxShadow: [BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.15), offset: Offset(0, -2), blurRadius: 5.0)]),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
          Text("Out of Stock", style:TextStyleUtil.textBold(fontSz:20, tColor: Colors.red))
        ]));
    }else{
      return Container(
          width:MediaQuery.of(context).size.width,
          height:200,
          child:Row(children:[
            Container(
                          height: 150,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                              boxShadow: [BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.15), offset: Offset(0, -2), blurRadius: 5.0)]),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width - 40,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        "Quantity",
                                        style: Theme.of(context).textTheme.subtitle1,
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        IconButton(
                                          onPressed: () {
                                            presenter.decrement();
                                          },
                                          iconSize: 30,
                                          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                          icon: Icon(Icons.remove_circle_outline),
                                          color: Theme.of(context).hintColor,
                                        ),
                                        Text(presenter.quantity.toString(), style: Theme.of(context).textTheme.subtitle1),
                                        IconButton(
                                          onPressed: () {
                                            presenter.increment();
                                          },
                                          iconSize: 30,
                                          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                          icon: Icon(Icons.add_circle_outline),
                                          color: Theme.of(context).hintColor,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height:20),
                                addToCart()
                              ]),
                        ))
            ]));

        }

    }
  }

  Widget addToCart(){
    return GestureDetector(onTap:(){
      presenter.addToCart();
    }, child: Container(
      padding:EdgeInsets.all(20),
      color:Colors.red,
      child:Row(children:[
      Icon(Icons.shopping_cart, size:20, color:Colors.white),
      SizedBox(width:10),
      Text("Add To Cart", style:TextStyleUtil.textBold(fontSz:15, tColor:Colors.white))
    ])));
  }



  Widget bodyData(){
    return (presenter.selectedProd == null || presenter.selectedProd.image == null) && presenter.selectedStore == null
          ? CircularLoadingWidget(height: 500)
          : RefreshIndicator(
              onRefresh: presenter.refresh,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 125),
                    padding: EdgeInsets.only(bottom: 15),
                    child: CustomScrollView(
                      primary: true,
                      shrinkWrap: false,
                      slivers: <Widget>[
                        SliverAppBar(
                          backgroundColor: Theme.of(context).accentColor.withOpacity(0.9),
                          expandedHeight: 300,
                          elevation: 0,
                          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
                          flexibleSpace: FlexibleSpaceBar(
                            collapseMode: CollapseMode.parallax,
                            background: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: Constants.instance.baseURL+presenter.selectedProd.image,
                                placeholder: (context, url) => Image.asset(
                                  'assets/images/loader/loading.gif',
                                  fit: BoxFit.cover,
                                ),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            child: Wrap(
                              runSpacing: 8,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(children:[
                                            Text(
                                              presenter.selectedProd.name ?? '',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: Theme.of(context).textTheme.headline3,
                                            ),
                                            Text(Constants.instance.currency+presenter.selectedProd.price.toString(), style:TextStyleUtil.textBold(fontSz:15, tColor: Colors.grey))
                                          ]),
                                          Text(
                                            presenter.selectedStore.store_info.name ?? '',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: Theme.of(context).textTheme.bodyText2,
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Expanded(
                                    //   flex: 1,
                                    //   child: Column(
                                    //     crossAxisAlignment: CrossAxisAlignment.end,
                                    //     children: <Widget>[
                                    //       Helper.getPrice(
                                    //         _con.food.price,
                                    //         context,
                                    //         style: Theme.of(context).textTheme.headline2,
                                    //       ),
                                    //       _con.food.discountPrice > 0
                                    //           ? Helper.getPrice(_con.food.discountPrice, context,
                                    //               style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(decoration: TextDecoration.lineThrough)))
                                    //           : SizedBox(height: 0),
                                    //     ],
                                    //   ),
                                    // ),
                                  ],
                                ),
                                // Row(
                                //   children: <Widget>[
                                //     Container(
                                //       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                                //       decoration: BoxDecoration(
                                //           color: Helper.canDelivery(_con.food.restaurant) && _con.food.deliverable ? Colors.green : Colors.orange,
                                //           borderRadius: BorderRadius.circular(24)),
                                //       child: Helper.canDelivery(_con.food.restaurant) && _con.food.deliverable
                                //           ? Text(
                                //               S.of(context).deliverable,
                                //               style: Theme.of(context).textTheme.caption.merge(TextStyle(color: Theme.of(context).primaryColor)),
                                //             )
                                //           : Text(
                                //               S.of(context).not_deliverable,
                                //               style: Theme.of(context).textTheme.caption.merge(TextStyle(color: Theme.of(context).primaryColor)),
                                //             ),
                                //     ),
                                //     Expanded(child: SizedBox(height: 0)),
                                //     Container(
                                //         padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                                //         decoration: BoxDecoration(color: Theme.of(context).focusColor, borderRadius: BorderRadius.circular(24)),
                                //         child: Text(
                                //           _con.food.weight + " " + _con.food.unit,
                                //           style: Theme.of(context).textTheme.caption.merge(TextStyle(color: Theme.of(context).primaryColor)),
                                //         )),
                                //     SizedBox(width: 5),
                                //     Container(
                                //         padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                                //         decoration: BoxDecoration(color: Theme.of(context).focusColor, borderRadius: BorderRadius.circular(24)),
                                //         child: Text(
                                //           _con.food.packageItemsCount + " " + S.of(context).items,
                                //           style: Theme.of(context).textTheme.caption.merge(TextStyle(color: Theme.of(context).primaryColor)),
                                //         )),
                                //   ],
                                // ),
                                Divider(height: 20),
                                Text(presenter.selectedProd.description),
                                // Helper.applyHtml(context, presenter.selectedProd.description, style: TextStyle(fontSize: 12)),
                                ListTile(
                                  dense: true,
                                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                                  leading: Icon(
                                    Icons.add_circle,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                ListTile(
                                  dense: true,
                                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                                  leading: Icon(
                                    Icons.recent_actors,
                                    color: Theme.of(context).hintColor,
                                  ),
                                  title: Text(
                                    "Reviews",
                                    style: Theme.of(context).textTheme.subtitle1,
                                  ),
                                ),
                                // ReviewsListWidget(
                                //   reviewsList: _con.food.foodReviews,
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: 150,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                          boxShadow: [BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.15), offset: Offset(0, -2), blurRadius: 5.0)]),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 40,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    "Quantity",
                                    style: Theme.of(context).textTheme.subtitle1,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    IconButton(
                                      onPressed: () {
                                        presenter.increment();
                                      },
                                      iconSize: 30,
                                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                      icon: Icon(Icons.remove_circle_outline),
                                      color: Theme.of(context).hintColor,
                                    ),
                                    Text(presenter.quantity.toString(), style: Theme.of(context).textTheme.subtitle1),
                                    IconButton(
                                      onPressed: () {
                                        presenter.decrement();
                                      },
                                      iconSize: 30,
                                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                      icon: Icon(Icons.add_circle_outline),
                                      color: Theme.of(context).hintColor,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ]),
                    )))])
                    );
  }
}



