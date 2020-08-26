

import 'package:clean_data/model/userstore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:foody_ui/components/carditem/carditem.widget.dart';
import 'package:foody_ui/components/progress/circularloading.progress.dart';
import 'package:foody_ui/typdef/mytypedef.dart';
import 'package:livingsmart_app/components/categorieswidget.ui.dart';
import 'package:livingsmart_app/components/widgets.ui.dart';
import 'package:livingsmart_app/config/constants.dart';
import 'package:livingsmart_app/services/navigator.service.dart';



class HomeSubPage extends StatelessWidget {
  final NormalCallback refreshHome;
  final NormalCallback direction;
  final GetStringData selectedCategory;
  final HomeSubPageVM vm;
  HomeSubPage(this.vm, this.refreshHome, this.direction, this.selectedCategory);

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

              Container(
                padding:EdgeInsets.only(left:30, right:30, top:10),
                child:WidgetUI.instance.clickableTextField((){
                  NavigatorService.instance.toSearchProduct(context);
              }, (){}, hintText:"Product Search")),
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
              productCategory(context)
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
        items.add(CardWidget((){
          //TODO: Direction of store
          Constants.instance.storeDirectionSelected=element;
          this.direction();
        },(){
          //TODO: click
          print("Fetching store info");
          Constants.instance.selectedStoreId=element.id;
          NavigatorService.instance.toStoreInfo(context);
        }, vm:CardWidgetVM(element.id.toString(),  element.distance+" km", title:element.name, subtitle:element.description != "" ? element.description : "", image: element.image != "null" ? Constants.instance.baseURL+element.image : Constants.instance.noImageDefault, loaderPlaceholder: "assets/images/loader/loading.gif", review:element.rate != "" ? element.rate : "0.0", openS: element.closed == 0 ? "Open" : "Closed", pickupS: element.delivery == 0 ? "Pickup" : "Delivery" )));
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
  Widget productCategory(BuildContext context){
    return vm.categoryItems != null ? 
     Column(children:[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  leading: Icon(
                    Icons.category,
                    color: Theme.of(context).hintColor,
                  ),
                  title: Text(
                    "Product Categories",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ),
              CategoriesCarouselWidget(this.selectedCategory,
                categories: vm.categoryItems
              ),
     ]) : CircularLoadingWidget(height:40);
  }

}

class HomeSubPageVM{
 List<LivingSmartStores> stores = [];
 List<CategoryItems> categoryItems;
 String address;
 HomeSubPageVM(this.stores, {this.address="Address Here", this.categoryItems});
}