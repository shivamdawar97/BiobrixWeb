import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myapp/config/config.dart';
import 'package:myapp/utils/MyMouseRegion.dart';
import 'package:myapp/utils/responsive_builder.dart';
import 'package:myapp/utils/screen_type.dart';

BuildContext _context;
class TopView extends StatelessWidget{
  final widgets = <Widget>[
            Text('info@biobrix.com',style: TextStyle(fontSize: 12,color: Colors.grey[600])),
            Text('+091232323232',style: TextStyle(fontSize: 12,color: Colors.grey[600])),
            Text('Media Gallery',style: TextStyle(fontSize: 12,color: Colors.grey[600])),
            Text('Employee Corner',style: TextStyle(fontSize: 12,color: Colors.grey[600])),
            Icon(Icons.shopping_cart),
            Icon(Icons.favorite),
            FaIcon(FontAwesomeIcons.facebook),
            FaIcon(FontAwesomeIcons.instagram)
            ];
  @override
  Widget build(BuildContext context) {
    _context = context;
    return ResponsiveBuilder(builder: (context,sizingInfo){
      return Container(
        padding: EdgeInsets.only(left: 10,right: 10),
        color: Colors.grey[200],
        child: sizingInfo.deviceScreenType == DeviceScreenType.Desktop?  _getWebUI() : _getMobileUI(),
      );
    },);
  }

_getWebUI(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Container(),
      _getListWidget(0),
      _getListWidget(1),
      _getListWidget(2),
      _getListWidget(3),
      Row(children: <Widget>[
      _getListWidget(4),
      _getListWidget(5),
      _getListWidget(6),
      _getListWidget(7),
      ],),
      Container()
      
  ],);
}  

_getMobileUI(){

  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: <Widget>[
     _getListWidget(4),
     _getListWidget(5),],),
      Wrap(    
    direction: Axis.horizontal,
    children: <Widget>[
      _getListWidget(0),
      _getListWidget(1),
      _getListWidget(2),
      _getListWidget(3),
  ],)
    ],
  );
}

_getListWidget(int pos){

  return Padding(padding: EdgeInsets.all(8.0),
  child: MyMouseRegion(
    child: widgets[pos],
    onTap: ()=> _onItemClicked(pos),
  ),);

}

_onItemClicked(int pos){
  var text = '';
  switch (pos) {
      case 0: text= 'mail'; break;
      case 1: text= 'phone'; break;
      case 2: text= 'Media Gallery'; break;
      case 3: text= 'Employee corner'; break;
      case 4: text= 'shopping cart'; break;
      case 5: text= 'Facebook'; break;
      default:  text= 'Instagram';
    }
  var d= AlertDialog(
    title: Text('Item Clicked'),
    content: Text(text),
    actions: <Widget>[
        FlatButton(onPressed: (){
          Navigator.pop(_context);
        }, child: Text('Ok'))
    ],
  );
  showDialog(context: _context,builder: (_)=> d);
}

}