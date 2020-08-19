

import 'package:firebase_database/firebase_database.dart';
import 'package:foody_ui/typdef/mytypedef.dart';

class FirebaseDatabaseService{
  static FirebaseDatabaseService instance=FirebaseDatabaseService();

  listenDeliveryStatus(String transactionID, GetStringData invokeEvent){
      FirebaseDatabase.instance.reference().child("deliveries").child(transactionID).onChildChanged.listen((data){
        if(data.snapshot.value != null){
          invokeEvent(data.snapshot.value.toString());
        }
      });
  }

}