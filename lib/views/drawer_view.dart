import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10.0,
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 30, 10, 20),  
        width: MediaQuery.of(context).size.width * 0.65,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Center(child: Text('BIOBRIX',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
            SizedBox(height: 30,),
            Center(child: Text('About Us')),
            Center(child: Text('Product')),
            Row(children: <Widget>[Spacer(),Text('Hair')],),
            Row(children: <Widget>[Spacer(),Text('Skin')],),
            Row(children: <Widget>[Spacer(),Text('Face')],),
            Center(child: Text('Trade Enquiry')),
            Center(child: Text('Contact Us')),
            Spacer()
          ],
        ),
      ),
    );
  }

}