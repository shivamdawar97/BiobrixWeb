import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myapp/models/testimony.dart';

class TestimonyCard extends StatelessWidget {

  TestimonyCard(this.testimony);

  final Testimony testimony;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white)
          ),
          child: Column(children: <Widget>[
            FaIcon(FontAwesomeIcons.highlighter),

            Text(testimony.text,style: TextStyle(fontSize: 18,color: Colors.white),),

            FaIcon(FontAwesomeIcons.highlighter),
          ],),
        ),

        SizedBox(height:150),

        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: Colors.white24
          ),
          child: Row(children: <Widget>[
           Image.network(testimony.image,width: 100,height: 100,fit: BoxFit.fill,),
           Expanded(child: Center(child: 
           Text(testimony.name,style: TextStyle(color:Colors.white,fontSize: 20),)),flex: 1) 
        ],),
        )

      ],
    );
  }

}