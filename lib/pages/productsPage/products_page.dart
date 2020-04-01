import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/categoty.dart';
import 'package:myapp/pages/productsPage/category_menu.dart';
import 'package:myapp/utils/screen_type.dart';

class ProductsPage extends StatelessWidget {

  final List<Category> categories;
  final int selected;
  final DeviceScreenType screenType; 
  final onCategorySelected;

  const ProductsPage(this.categories, this.selected,{Key key,this.screenType,this.onCategorySelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
                  Text(categories[selected].name,style: TextStyle(fontSize: 22,color: Colors.blue ),),
                  SizedBox(height: 20,),
                  Row(
                    children: <Widget>[
                    Expanded(child: CategoryMenu(categories,selected,onCategorySelected: (id) => onCategorySelected(id),),flex: 1,),
                    Expanded(child: Container(),flex: 3,),
              ],)

      ],
    );
  }


}