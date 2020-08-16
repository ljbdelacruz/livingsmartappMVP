

import 'package:clean_data/model/userstore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:foody_ui/components/buttons/shoppingcart.button.dart';
import 'package:foody_ui/components/carditem/carditem.widget.dart';
import 'package:foody_ui/services/color.service.dart';
import 'package:foody_ui/subui/loader.subui.dart';
import 'package:foody_ui/subui/tableviewcells.subui.dart';
import 'package:foody_ui/typdef/mytypedef.dart';
import 'package:livingsmart_app/config/constants.dart';
import 'package:livingsmart_app/services/navigator.service.dart';



class HomeSubPage extends StatelessWidget {
  final NormalCallback refreshHome;
  final HomeSubPageVM vm;
  HomeSubPage(this.vm, this.refreshHome);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: refreshHome,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  leading: Icon(
                    Icons.stars,
                    color: Theme.of(context).hintColor,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                    },
                    icon: Icon(
                      Icons.my_location,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  title: Text(
                    "Nearest Living Smart Store",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  subtitle: Text(
                    vm.address
                    // S.of(context).near_to + " " + (settingsRepo.deliveryAddress.value?.address ?? S.of(context).unknown),
                    // style: Theme.of(context).textTheme.caption,
                  ),
                ),
              ),
              storeList(context),
              //TODO: List of Living Smart Data
              // CardsCarouselWidget(restaurantsList: _con.topRestaurants, heroTag: 'home_top_restaurants'),

            ],
          ),
        ),
      ),
    );
  }


  Widget storeList(BuildContext context){
    List<Widget> items = [];
    if(vm.stores == null){
      return Image.asset("assets/images/loader/loading_card.gif", width:300, height:200, fit:BoxFit.contain);
    }else{
      vm.stores.forEach((element) { 
        // items.add(Text(element.name));
        items.add(CardWidget((){},(){
          //TODO: click
          print("Fetching store info");
          Constants.instance.selectedStoreId=element.id;
          NavigatorService.instance.toStoreInfo(context);
        }, vm:CardWidgetVM(element.id.toString(), "1 km", title:element.name, subtitle:element.description != "" ? element.description : "", image: element.image != "null" ? Constants.instance.baseURL+element.image : Constants.instance.noImageDefault, loaderPlaceholder: "assets/images/loader/loading.gif", review:element.rate != "" ? element.rate : "0.0", )));
      });
      if(items.length > 0){
        return SingleChildScrollView(scrollDirection: Axis.horizontal, child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:items));
      }else{
        return Image.asset("assets/images/loader/loading_card.gif", width:300, height:200, fit:BoxFit.contain);
      }
    }

  }

}

class HomeSubPageVM{
 List<LivingSmartStores> stores = [];
 String address;
 HomeSubPageVM(this.stores, {this.address="Address Here"});
}