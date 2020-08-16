




import 'package:clean_data/base/architechture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:livingsmart_app/config/constants.dart';
import 'package:livingsmart_app/pages/driver/driver.presenter.dart';
import 'package:livingsmart_app/pages/driver/subpage/driverhome.subpage.dart';
import 'package:livingsmart_app/pages/driver/subpage/joblist.subpage.dart';
import 'package:livingsmart_app/services/navigator.service.dart';

class DriverDashboardPage extends CleanPage {

  @override
  DriverDashboardPageState createState() => DriverDashboardPageState();
}

class DriverDashboardPageState extends CleanPageState<DriverPresenter> {
  @override
  DriverPresenter createPresenter() {
    return DriverPresenter(this);
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
          "MCS Dashboard",
          style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
        )
      ),
      body:bodyContent(),
      bottomNavigationBar: bottomNav(),
    ));
  }

  Widget bodyContent(){
    switch(presenter.selectedTab){
      case 0:
        return Container();
      case 1:
        return DriverHomeSubPage();
      case 2:
          return JobListSubPage(JobListSubPageVM(presenter.jobList, presenter.completedDeliveries, presenter.currentDeliveryInfo, presenter.currentActiveDelivery), (String transCode){
            //TODO: view job info
            Constants.instance.selectedJobTransCode=transCode;
            NavigatorService.instance.toDriverDirection(context);
          },(String transCode){
            //TODO: accept job
            presenter.acceptDelivery(transCode);
          }, (String transCode){
            //TODO: delivered job
            presenter.deliveredJob(transCode);
          });
    }
    return Column(children:[
      
    ]);
  }

  Widget bottomNav(){
    return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).accentColor,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          iconSize: 22,
          elevation: 0,
          backgroundColor: Colors.transparent,
          selectedIconTheme: IconThemeData(size: 28),
          unselectedItemColor: Theme.of(context).focusColor.withOpacity(1),
          currentIndex: presenter.selectedTab,
          onTap: (int i) {
            presenter.selectTab(i);
          },
          // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
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
              icon: new Icon(Icons.format_list_bulleted),
              title: new Container(height: 0.0),
            ),
          ],
        );
  }
}