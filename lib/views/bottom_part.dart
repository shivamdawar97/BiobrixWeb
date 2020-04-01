import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration:BoxDecoration(
        color: Colors.black38
      ),
      child: Row(
        children: <Widget>[
          SizedBox(width: 30,),
          Text('Copyright 2020 | All Rights Reserved | Biobrix',
          style: TextStyle(
          color: Colors.grey[200]
          ),),
          Spacer(),
          FaIcon(FontAwesomeIcons.facebook),
          SizedBox(width: 10,),
          FaIcon(FontAwesomeIcons.instagram),
          SizedBox(width: 30,),
        ],
      ),
    );
  }
  
}