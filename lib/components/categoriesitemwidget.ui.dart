import 'package:cached_network_image/cached_network_image.dart';
// import 'package:clean_data/config/constant.dart';
import 'package:flutter/material.dart';
import 'package:foody_ui/typdef/mytypedef.dart';
import 'package:livingsmart_app/components/categorieswidget.ui.dart';
import 'package:livingsmart_app/config/constants.dart';

// ignore: must_be_immutable
class CategoriesCarouselItemWidget extends StatelessWidget {
  double marginLeft;
  CategoryItems category;
  final GetStringData selectedItem;
  CategoriesCarouselItemWidget(this.selectedItem, {Key key, this.marginLeft, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      highlightColor: Colors.transparent,
      onTap: () {
        // Navigator.of(context).pushNamed('/Category', arguments: RouteArgument(id: category.id));
        this.selectedItem(category.description);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Hero(
            tag: category.id,
            child: Container(
              margin: EdgeInsetsDirectional.only(start: this.marginLeft, end: 20),
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: [BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.2), offset: Offset(0, 2), blurRadius: 7.0)]),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: category.image != null
                    ? CachedNetworkImage(imageUrl: Constants.instance.baseURL+category.image)
                    : CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: Constants.instance.baseURL+category.image,
                        placeholder: (context, url) => Image.asset(
                          'assets/images/loader/loading.gif',
                          fit: BoxFit.cover,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Container(
            margin: EdgeInsetsDirectional.only(start: this.marginLeft, end: 20),
            child: Text(
              category.description,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ],
      ),
    );
  }
}
