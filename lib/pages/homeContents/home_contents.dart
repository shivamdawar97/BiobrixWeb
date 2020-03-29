import 'package:flutter/cupertino.dart';
import 'package:myapp/models/product.dart';
import 'package:myapp/models/testimony.dart';
import 'package:myapp/utils/size_info.dart';
import 'package:myapp/views/ViewPager.dart';
import 'package:myapp/views/bottom_part.dart';
import 'package:myapp/views/customer_says.dart';
import 'package:myapp/views/recent_products_view.dart';
import 'package:myapp/views/skin_type_view.dart';

class HomeContents extends StatelessWidget {

  final List<HomeProduct> products;
  final List<Testimony> tetimonies;
  final SizingInformation sizingInfo;

  const HomeContents({Key key, this.products, this.tetimonies, this.sizingInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Column(    
      children: <Widget>[
        ViewPager(),
        SkinTypeProductsView(screentype: sizingInfo.deviceScreenType),
        products==null? Container(): RecentProductsView(sizingInfo.deviceScreenType,products),
        CustomerSays(tetimonies),
        BottomView()
        ],);
  }

}