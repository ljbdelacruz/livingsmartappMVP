



import 'package:clean_data/model/address.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:foody_ui/typdef/mytypedef.dart';
import 'package:livingsmart_app/config/constants.dart';

class PickerModalService{
  static PickerModalService instance = PickerModalService();


  pickerAddress(BuildContext context, GetLSAddress callback){
    List<String> state = [];
    Constants.instance.userAddresses.forEach((item){
      state.add(item.address);
    });
    this.showModal(context, state, (data){
      callback(Constants.instance.userAddresses.where((element) => element.address == data).first);
    });
  }

  showModal(BuildContext context, List<String> data, GetStringData callback){
    Picker(
        adapter: PickerDataAdapter<String>(pickerdata: data),
        changeToFirst: true,
        hideHeader: false,
        selectedTextStyle: TextStyle(color: Colors.blue),
        onConfirm: (Picker picker, List value) {
          String selectedData=picker.adapter.text.replaceAll("]", "");
          selectedData=selectedData.replaceAll("[", "");
          callback(selectedData);
        }
    ).showModal(context);
  }

}


typedef GetLSAddress(LSAddress address);