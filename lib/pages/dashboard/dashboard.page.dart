



import 'package:clean_data/base/architechture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:livingsmart_app/config/constants.dart';
import 'package:livingsmart_app/pages/dashboard/dashboard.presenter.dart';
import 'package:foody_ui/components/drawer/livingsmart.drawer.dart';
import 'package:livingsmart_app/pages/dashboard/subpage/home.subpage.dart';

class DashboardPage extends CleanPage {

  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends CleanPageState<DashboardPresenter> {
  @override
  DashboardPresenter createPresenter() {
    return DashboardPresenter(this);
  }

  @override
  void initState() { 
    super.initState();
    Constants.instance.parentScaffoldKey=presenter.scaffoldKey;
  }

  Widget bodyContent(){
          switch (presenter.currentTab) {
        case 0:
          return Container();
          break;
        case 1:
          return Container();
          break;
        case 2:
          return HomeSubPage(presenter.homeSubpage, (){
            //TODO: refresh home
          });
          break;
        case 3:
          return Container();
          break;
        case 4:
          return Container();
          break;
      }

  }

  void _selectTab(int tabItem) {
    setState(() {
      presenter.currentTab = tabItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: presenter.scaffoldKey,
        drawer: LivingSmartDrawer(presenter.drawerVM, (){}, (option){
          presenter.navigateSideMenu(option);
        }),
        // endDrawer: FilterWidget(onFilter: (filter) {
        //   // Navigator.of(context).pushReplacementNamed('/Pages', arguments: widget.currentTab);
        // }),
        body: bodyContent(),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).accentColor,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          iconSize: 22,
          elevation: 0,
          backgroundColor: Colors.transparent,
          selectedIconTheme: IconThemeData(size: 28),
          unselectedItemColor: Theme.of(context).focusColor.withOpacity(1),
          currentIndex: presenter.currentTab,
          onTap: (int i) {
            this._selectTab(i);
          },
          // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              title: new Container(height: 0.0),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              title: new Container(height: 0.0),
            ),
            BottomNavigationBarItem(
                title: new Container(height: 5.0),
                icon: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                    boxShadow: [
                      BoxShadow(color: Theme.of(context).accentColor.withOpacity(0.4), blurRadius: 40, offset: Offset(0, 15)),
                      BoxShadow(color: Theme.of(context).accentColor.withOpacity(0.4), blurRadius: 13, offset: Offset(0, 3))
                    ],
                  ),
                  child: new Icon(Icons.home, color: Theme.of(context).primaryColor),
                )),
            BottomNavigationBarItem(
              icon: new Icon(Icons.shopping_cart),
              title: new Container(height: 0.0),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.favorite),
              title: new Container(height: 0.0),
            ),
          ],
        ),
      ),
    );
  }
}