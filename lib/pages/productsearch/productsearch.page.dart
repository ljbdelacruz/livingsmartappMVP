


import 'package:clean_data/base/architechture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';
import 'package:foody_ui/components/progress/circularloading.progress.dart';
import 'package:livingsmart_app/components/widgets.ui.dart';
import 'package:livingsmart_app/config/constants.dart';
import 'package:livingsmart_app/pages/productsearch/productsearch.presenter.dart';

class ProductSearchPage extends CleanPage {
  @override
  ProductSearchPageState createState() => ProductSearchPageState();
}

class ProductSearchPageState extends CleanPageState<ProductSearchPresenter> {
  
  @override
  ProductSearchPresenter createPresenter() {
    return ProductSearchPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(child: Scaffold(
      key:presenter.scaffoldKey,
      body:SingleChildScrollView(child:Column(children:[
        heading(),
        Container(
          padding:EdgeInsets.only(left:30, right:30, top:20),
          child:this.searchBar()),
        productsSearch(),
      ]))
    ));
  }

  Widget heading(){
    return Padding(
            padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 0),
              trailing: IconButton(
                icon: Icon(Icons.close),
                color: Theme.of(context).hintColor,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                "Search",
                style: Theme.of(context).textTheme.headline4,
              ),
              subtitle: Text(
                "LivingSmart Products",
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          );
  }
  Widget searchBar(){
    return Container(
      height:50,
      child: TextField(
              onChanged: (text) async{
                if(text == ""){
                  presenter.fetchProducts("all");
                }
              },
              onSubmitted: (text) async {
                presenter.fetchProducts(text);
              },
              autofocus: presenter.autoFocusTF,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(12),
                hintText: "Product Search",
                hintStyle: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 14)),
                prefixIcon: Icon(Icons.search, color: Theme.of(context).accentColor),
                border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1))),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.3))),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1))),
              ),
            )
    );
  }

  Widget productsSearch(){
    return presenter.products.length <= 0 ? CircularLoadingWidget(height: 0)  : Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height-150,
      child: SafeArea(
        child: SectionTableView(
          sectionCount: 1,
          numOfRowInSection: (section) {
            return presenter.products.length;
          },
          cellAtIndexPath: (section, row) {
            var item = presenter.products[row];
            return GestureDetector(onTap:(){
              //TODO: show product info
              presenter.viewProductInfo(item);
            }, child: WidgetUI.instance.productItemTBView(context, item.image != null ? Constants.instance.baseURL+item.image : Constants.instance.noImageDefault, item.name, ""));
          },
          divider: Container(
            color: Colors.grey,
            height: 1.0,
          ),
        ),
      ),
    );
  }



  
}