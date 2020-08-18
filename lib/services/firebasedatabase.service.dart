

import 'package:firebase_database/firebase_database.dart';
import 'package:foody_ui/typdef/mytypedef.dart';

class FirebaseDatabaseService{
  static FirebaseDatabaseService instance=FirebaseDatabaseService();

  listenDeliveryStatus(String transactionID, GetStringData invokeEvent){
      print("Accessing firebase Database");
      print(transactionID);
      FirebaseDatabase.instance.reference().child("delveries").child(transactionID).onChildChanged.listen((data){
        if(data.snapshot.value != null){
          print("Accessing value");
          print(data.snapshot.value.toString());
          invokeEvent(data.snapshot.value.toString());
        }
      });
  }

}