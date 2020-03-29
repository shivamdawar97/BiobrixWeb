import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/testimony.dart';

class TestimonyCard extends StatelessWidget {

  TestimonyCard(this.testimony);

  final Testimony testimony;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

        Card(
            elevation: 6,
            color: Colors.transparent,
            child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white,width: 2),
            ),
            child: Column(children: <Widget>[

              Align(alignment: Alignment.topLeft,
              child: Text('“',style: TextStyle(fontSize:50,fontWeight: FontWeight.w800,fontStyle: FontStyle.italic,color: Colors.white))) ,

              Text(testimony.text,style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w500),),

              Align(alignment: Alignment.bottomRight,
              child: Text('”',style: TextStyle(fontSize:50,fontWeight: FontWeight.w800,fontStyle: FontStyle.italic,color: Colors.white))) ,


            ],),
          ),
        ),

        SizedBox(height:10),

        Row(children: <Widget>[
             Spacer(), 
              Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: Colors.white24
          ),
          child: Row(children: <Widget>[
          
           Image.network(testimony.image,width: 60,height: 60,fit: BoxFit.fill,),
           SizedBox(width: 60,),
           Text(testimony.name,style: TextStyle(color:Colors.white,fontSize:22,fontWeight: FontWeight.w600),),
           SizedBox(width: 60,),

        ],),
        ),

             Spacer(),
        ],),

      ],
    );
  }

}