



import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';
import 'package:foody_ui/components/progress/circularloading.progress.dart';
import 'package:foody_ui/typdef/mytypedef.dart';
import 'package:foody_ui/util/text_style_util.dart';
import 'package:geolocator/geolocator.dart';

class SelectAddressPage extends StatefulWidget{
  final List<Placemark> items;
  final GetIntData selectedIndex;
  SelectAddressPage(this.items, this.selectedIndex);
  @override
  SelectAddressPageState createState() => SelectAddressPageState();
}
class SelectAddressPageState extends State<SelectAddressPage>{


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Select Address",
            style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
          ),
        ),
        body:bodyContent()
    );
  }
  Widget bodyContent(){
    return widget.items.length <= 0 ? CircularLoadingWidget(height: 0) : SectionTableView(
          sectionCount: 1,
          numOfRowInSection: (section) {
            return widget.items.length;
          },
          cellAtIndexPath: (section, row) {
            var item = widget.items[row];
            return GestureDetector(onTap:(){
              print("selected item");
              widget.selectedIndex(row);
            }, child: addressCell(item));
          },
          divider: Container(
            color: Colors.grey,
            height: 1.0,
          ),
        );
  }
  Widget addressCell(Placemark address){
    return Container(
      padding:EdgeInsets.all(20),
      child: Text(address.name+","+address.country+","+address.locality+","+address.subAdministrativeArea+" "+address.subLocality+" "+address.thoroughfare+" "+address.subThoroughfare, style:TextStyleUtil.textNormal(fontSz:15, tColor:Colors.grey)));
  }

}
