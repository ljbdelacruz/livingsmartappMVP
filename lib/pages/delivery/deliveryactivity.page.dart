


import 'package:clean_data/base/architechture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foody_ui/components/animation/lottieviewer1.animation.dart';
import 'package:foody_ui/util/app_color_util.dart';
import 'package:livingsmart_app/pages/delivery/deliveryactivity.presenter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class DeliveryActivityPage extends CleanPage {

  @override
  DeliveryActivityPageState createState() => DeliveryActivityPageState();
}

class DeliveryActivityPageState extends CleanPageState<DeliveryActivityPresenter> {
  @override
  DeliveryActivityPresenter createPresenter() {
    return DeliveryActivityPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: CloseButton(
          // color: AppColors.description,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Container(
            margin: EdgeInsets.only(top: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 180.0,
                  child: Center(
                    child: Viewer1Lottie(presenter.anim)
                    // child: Image.asset(
                    //   "assets/images/delivery.png",
                    //   fit: BoxFit.fill,
                    // ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30, bottom: 5.0),
                  child: Text(
                    presenter.title,
                    style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: Text(
                    presenter.subDesc,
                    style:
                        TextStyle(fontSize: 14.0, color: AppColors.cardStatus),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 5.0),
                          child:
                              Text((presenter.progress * 100).toString()+"%", style: TextStyle(fontSize: 14.0))),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 30.0),
                        child: new LinearPercentIndicator(
                          lineHeight: 12.0,
                          percent: presenter.progress,
                          progressColor: AppColors.primaryBlue,
                          backgroundColor: Colors.lightGreen,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: 20.0),
                    _buildPersonalInformationAchievements(
                        "Requesting Order", presenter.status >= 1 ? true : false),
                    _buildPersonalInformationAchievements(
                        "Preparing Order Order", presenter.status >= 2 ? true : false),
                    _buildPersonalInformationAchievements(
                        "Order Ready For Pickup", presenter.status >= 3 ? true : false),
                    _buildPersonalInformationAchievements(
                        "Out for Delivery", presenter.status >= 4 ? true : false),
                    _buildPersonalInformationAchievements(
                        "Delivered", presenter.status >= 5 ? true : false),
                  ],
                ),
                _buildCloseButton(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(35, 40, 35, 20),
      child: FlatButton(
        color: Colors.blue,
        onPressed: () async {
          Navigator.pop(context);
        },
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(25.0),
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
          child: Center(
              child: Text(
            "Close",
            style: TextStyle(
              color: Colors.white,
            ),
          )),
        ),
      ),
    );
  }

  Widget _buildPersonalInformationAchievements(
      String label, bool hasCompleted) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7, horizontal: 35),
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    child: Text(
                  label,
                  style: TextStyle(
                      fontSize: 13.0,
                      color: !hasCompleted
                          ? Colors.black
                          : AppColors.chipBorder),
                )),
                !hasCompleted
                    ? Container(
                        width: 20.0,
                        height: 20.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: new Border.all(
                              color: AppColors.cardStatus,
                              width: 1.0,
                            )),
                      )
                    : Container(
                        width: 20.0,
                        height: 20.0,
                        decoration: BoxDecoration(
                          color: AppColors.cardStatus,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.check, color: Colors.white, size: 15),
                      )
              ],
            ),
          ),
          SizedBox(
            height: 17.0,
          ),
          Divider(
            height: 0,
          ),
        ],
      ),
    );
  }

}