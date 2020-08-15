



import 'package:clean_data/base/architechture.dart';
import 'package:clean_data/model/address.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';
import 'package:foody_ui/typdef/mytypedef.dart';
import 'package:foody_ui/util/text_style_util.dart';
import 'package:livingsmart_app/pages/address/address.presenter.dart';
import 'package:livingsmart_app/services/navigator.service.dart';

class DeliveryAddressPage extends CleanPage {
  @override
  DeliveryAddressPageState createState() => DeliveryAddressPageState();
}

class DeliveryAddressPageState extends CleanPageState<AddressPresenter> {
  @override
  AddressPresenter createPresenter() {
    return AddressPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(child: Scaffold(
        key:presenter.scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Delivery Address",
            style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
          ),
        ),
      body:deliveryAddress(),
      bottomNavigationBar: bottomNavBar(),
      ));
  }
  Widget bottomNavBar(){
    return GestureDetector(onTap:(){
      NavigatorService.instance.toAddAddress(context);
    }, child: Container(
      color:Colors.red,
      height:80,
      width:MediaQuery.of(context).size.width,
      child: Center(child:Icon(Icons.add, size:30, color:Colors.white))
    ));
  }

  Widget deliveryAddress(){
    return SectionTableView(
          sectionCount: 1,
          numOfRowInSection: (section) {
            return presenter.userAddresses.length;
          },
          onRefresh: (onRefresh){
            print("Refreshing data");
            print(onRefresh);
            if(onRefresh){
              presenter.getCustomerAddresses();
            }
          },
          cellAtIndexPath: (section, row) {
            var item = presenter.userAddresses[row];
            return addressCell(item, (){
              //view info
            }, (){
              //remove
              presenter.removeAddress(row);
            });
          },
          divider: Container(
            color: Colors.grey,
            height: 1.0,
          ),
        );

  }
  Widget addressCell(LSAddress address, NormalCallback click, NormalCallback remove){
    return Dismissible(
      key: ValueKey(address),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 7,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        //on dismissed qr
        remove();
      },
      child: GestureDetector(onTap:click, 
      child:  Container(
      padding:EdgeInsets.all(20),
      child: Row(children:[
        Container(
          width:MediaQuery.of(context).size.width-150,
          child:Text(address.address, style:TextStyleUtil.textNormal(fontSz:12, tColor:Colors.grey))),
        address.isDefault == 0 ? OutlineButton(onPressed: (){
          presenter.setDefault(address);
        }, child:Text("DEFAULT", style:TextStyleUtil.textNormal(fontSz:9, tColor:Colors.grey))) : Container()
      ])),
      )
    );

  }

  
  
}