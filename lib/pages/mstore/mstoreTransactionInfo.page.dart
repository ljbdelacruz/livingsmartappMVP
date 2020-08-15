




import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_data/base/architechture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';
import 'package:foody_ui/components/progress/circularloading.progress.dart';
import 'package:foody_ui/util/text_style_util.dart';
import 'package:livingsmart_app/config/constants.dart';
import 'package:livingsmart_app/pages/mstore/mstoretransaction.presenter.dart';
import 'package:foody_ui/components/carditem/carditem1.widget.dart';
import 'package:clean_data/model/transactions.dart';
import 'package:livingsmart_app/services/navigator.service.dart';

class MStoreTransactionInfoPage extends CleanPage {
  @override
  MStoreTransactionInfoPageState createState() => MStoreTransactionInfoPageState();
}

class MStoreTransactionInfoPageState extends CleanPageState<MStoreTransactionPresenter> {
  
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
          "Transaction Info",
          style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
      )),
      body:bodyContent()
      )
    );
  }
  Widget bodyContent(){
    return presenter.selectedTransaction == null ? CircularLoadingWidget(height: 0) : Container(child:Column(children:[
      Container(
        padding:EdgeInsets.only(left:20, right:20, top:20),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
          Text("Customer Name: "+presenter.selectedTransaction.details.customer_name, style:TextStyleUtil.textBold(fontSz:12, tColor:Colors.grey)),
          Text("Address: "+presenter.selectedTransaction.details.delivery_address, style:TextStyleUtil.textBold(fontSz:12, tColor:Colors.grey)),
          Text("Mobile: "+presenter.selectedTransaction.details.customer_mobile, style:TextStyleUtil.textBold(fontSz:12, tColor:Colors.grey)),
        ])),
        SizedBox(height:20),
        Container(
            width: MediaQuery.of(context).size.width,
            height:MediaQuery.of(context).size.height/2,
            child:products()
        )
    ]));
  }

  Widget products(){
    return SectionTableView(
          sectionCount: 1,
          numOfRowInSection: (section) {
            return presenter.selectedTransaction.products.length;
          },
          cellAtIndexPath: (section, row) {
            var item = presenter.selectedTransaction.products[row];
            return productsCell(item, "assets/images/loader/loading.gif");
            // return CardItem1Widget(CardItem1WidgetVM("prod"+item.product_id.toString(), item.product_id.toString(), bgColor: Colors.white, image:Constants.instance.baseURL+item.image, name:item.name, quantity: item.quantity), (){}, (){});
          },
          divider: Container(
            color: Colors.grey,
            height: 1.0,
          ),
        );
  }
  Widget productsCell(MStoreTransactionItem item, String loadingGif){
    return InkWell(
        splashColor: Theme.of(context).accentColor,
        focusColor: Theme.of(context).accentColor,
        highlightColor: Theme.of(context).primaryColor,
        onTap:(){
          Constants.instance.selectedProdId=item.product_id;
          // NavigatorService.instance.toProductInfo(context);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 5, offset: Offset(0, 2)),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                child: CachedNetworkImage(
                  height: 90,
                  width: 90,
                  fit: BoxFit.cover,
                  imageUrl: Constants.instance.baseURL+item.image,
                  placeholder: (context, url) => Image.asset(
                    loadingGif,
                    fit: BoxFit.cover,
                    height: 90,
                    width: 90,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              SizedBox(width: 15),
              Flexible(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            item.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Text(
                            "x"+item.quantity.toString(),
                            style: TextStyleUtil.textBold(fontSz:12, tColor:Colors.grey),
                          ),

                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                  ],
                ),
              )
            ],
          ),
        ),
      );
  }


}