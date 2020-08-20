


import 'package:clean_data/base/architechture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
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
          child:this.searchBar())
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
              onSubmitted: (text) async {
                // await _con.refreshSearch(text);
                // _con.saveSearch(text);
              },
              autofocus: true,
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
    
  }


  
}