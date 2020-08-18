



import 'dart:async';

import 'package:clean_data/base/architechture.dart';
import 'package:clean_data/model/transactions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foody_ui/components/animation/lottieviewer1.animation.dart';
import 'package:livingsmart_app/config/constants.dart';
import 'package:livingsmart_app/services/delivery.service.dart';

class DeliveryActivityPresenter extends CleanPresenter {
 String title = "Preparing Order";
 String subDesc = "Please wait your driver will arrive at your door step in 10 to 15 minutes";
 double progress = 0.1;
 int status=1;
 Viewer1LottieVM anim = Viewer1LottieVM("assets/lottie/delivery.json");  
 GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
 UserTransaction userTransactionInfo;

 DeliveryActivityPresenter(CleanPageState<CleanPresenter> cleanPageState)
      : super(cleanPageState);

  @override
  void onViewInit() {
    anim.controller=AnimationController(vsync: cleanPageState);    
    this.userTransactionInfo=Constants.instance.inProgressTransaction;
    this.title=userTransactionInfo.status.toUpperCase();
    this.status=DeliveryService.instance.getIntDataByStatus(userTransactionInfo.status);
    this.progress=DeliveryService.instance.getProgressStatus(userTransactionInfo.status);
  }

  @override
  // TODO: implement streamControllers
  List<StreamController> get streamControllers => null;
}