import 'package:flutter/material.dart';
import 'package:myapp/config/config.dart';

//typedef PointerEventListener = void Function();

class MyMouseRegion extends StatelessWidget {

  final onEnter;
  final onExit;
  final child;
  final onTap;

  const MyMouseRegion({Key key, this.onEnter, this.onExit, this.child, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){if(onTap!=null)onTap();},
        child: MouseRegion(
        child: child,
        onEnter: (_) {
          appContainer.style.cursor = 'pointer';
          if(onEnter!=null)onEnter();
        },
        onExit: (_){
          appContainer.style.cursor = 'default';
          if(onExit!=null) onExit();
        },
      ),
    );
  } 



}