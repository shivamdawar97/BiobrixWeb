import 'package:flutter/material.dart';

typedef void PagePosition(int position);

class MyDotsIndicator extends StatefulWidget {

  MyDotsIndicator({this.dots,this.onSelected});

  final int dots;
  final PagePosition onSelected;
  final state = _MyDotsIndicator();

  @override
  State<StatefulWidget> createState() {
    return state;
  }

  void setCurrentPage(int page){
    if(page >=0 && page<dots ) state.updatePagePosition(page);
  }

}

class _MyDotsIndicator extends State<MyDotsIndicator> {

  int currentPos = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    for(int i=0; i<widget.dots;i++)
      widgets.add(IconButton(icon: Icon(Icons.lens,color: currentPos==i? Colors.blue:Colors.grey,size: 15,),
      onPressed: ()=>widget.onSelected(i)));
    return Center(child:
      Row( mainAxisAlignment: MainAxisAlignment.center,
        children: widgets
      )
    ,);  

  }

  void updatePagePosition(int pos){
    setState(() {
      currentPos = pos;      
    });
  }
  
}

