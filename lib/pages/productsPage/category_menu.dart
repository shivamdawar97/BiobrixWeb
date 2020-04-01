import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/categoty.dart';
import 'package:myapp/utils/MyMouseRegion.dart';
import 'package:myapp/utils/ui_utils.dart';

class CategoryMenu extends StatelessWidget {

  final List<Category> categories;
  final onCategorySelected;
  final int selected;
  
  const CategoryMenu(this.categories,this.selected,
  {Key key,this.onCategorySelected,}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final List<Widget> widgets = [];

    widgets.add(Center(child: Text('Categories',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white))));
    widgets.add(SizedBox(height:20));

    categories.asMap().forEach((pos,category) { 
      
      widgets.add(FlatButton(child: Container(
          color: selected ==  pos? Colors.blue[700] : Colors.blue,
          padding: EdgeInsets.all(10),
          child: Text(category.name,
          style: TextStyle(fontSize: 18,color: Colors.white,))
        ),
        onPressed: ()=> onCategorySelected(pos)));

    });

    return Container(
      width: deviceWidth/3.5,
      color: Colors.blue,
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: widgets
    ),
    );

  }

}