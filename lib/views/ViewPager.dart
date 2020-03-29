import 'dart:async';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


final _pageController = PageController(initialPage: 0);
var _initiateScroller = true;
Timer timer;

class ViewPager extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() => _ViewPagerState();

}

class _ViewPagerState extends State<ViewPager> {

 double _currentPos = 0;
 final decorator = DotsDecorator(
      activeColor: Colors.pink[200],
    );

  @override
  void initState() {
    super.initState();
    initiateScroller();
    _pageController.addListener(() { 
      setState(() {
        _currentPos = _pageController.page;
      });
    });

  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
  
   var width = MediaQuery.of(context).size.width;
   return Container(
      width: width,
      height: width/3,
      child: Stack(
        children: <Widget>[
           PageView(
          controller: _pageController,  
          children: <Widget>[
          Image.network('https://biobrix-files.s3.ap-south-1.amazonaws.com/images/1.jpg',fit: BoxFit.fill),
          Image.network('https://biobrix-files.s3.ap-south-1.amazonaws.com/images/10.jpg',fit: BoxFit.fill),
          Image.network('https://biobrix-files.s3.ap-south-1.amazonaws.com/images/3.jpg',fit: BoxFit.fill),
          Image.network('https://biobrix-files.s3.ap-south-1.amazonaws.com/images/4.jpg',fit: BoxFit.fill),
          Image.network('https://biobrix-files.s3.ap-south-1.amazonaws.com/images/5.jpg',fit: BoxFit.fill)
          ],),
          Positioned(left: 10,
          child: Container(height: width/3,
          child: Center(child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white30
            ),
            child: IconButton(icon: Icon(Icons.chevron_left,size: 30,), onPressed: (){
              scrollToPage(_pageController.page.toInt()-1);
              cancelTimer();
            }
            ,
            hoverColor: Colors.white,
            ),
          )))),
          Positioned(left: width-60,
          child: Container(height: width/3,
          child: Center(child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white30
            ),
            child: IconButton(icon: Icon(Icons.chevron_right,size: 30,), onPressed: (){
              scrollToPage(_pageController.page.toInt()+1);
              cancelTimer();
            },
            hoverColor: Colors.white,
            ),
          )))),

          Align(alignment: Alignment.bottomCenter,
          child: DotsIndicator(dotsCount: 5,
          position: _currentPos,
          axis: Axis.horizontal,
          decorator: decorator,
          ),)

        ],
      )
    );
  }

  void scrollToPage(int page,{int milliseconds = 400}){
      _pageController.animateToPage(page,duration: Duration(milliseconds: milliseconds),curve: Curves.decelerate);
  }

  void initiateScroller(){
      if(_initiateScroller){
     timer = Timer.periodic(Duration(seconds: 15), (timer) {
        int index = _pageController.page==4?0:_pageController.page+1;
        scrollToPage(index,milliseconds: 1500);
       });
       _initiateScroller = false;
       
       }  
  }

  void cancelTimer(){
    timer.cancel();
    _initiateScroller = true;
    initiateScroller();
  }

  

}

