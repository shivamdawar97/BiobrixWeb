import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/cards/testimony_card.dart';
import 'package:myapp/models/testimony.dart';
import 'package:myapp/utils/my_dots_indicator.dart';


PageController _pageController;
MyDotsIndicator _myDotsIndicator;


class CustomerSays extends StatelessWidget {

  CustomerSays(this.testimonies);
  final List<Testimony> testimonies;

  @override
  Widget build(BuildContext context) {

    _myDotsIndicator = MyDotsIndicator(dots:testimonies.length,
   onSelected: (page) => scrollToPage(page.toDouble()));
   
       return Container(child: Column(
         children: <Widget>[
           Center(child: Text('Testimonials',style: TextStyle(fontSize: 28))),
           Center(child: Container(height: 2,width: 100,color: Colors.black)),
           SizedBox(height: 300,),
           PageView.builder(itemBuilder: (ctx,pos){
             return TestimonyCard(testimonies[pos]);
             },itemCount: 3,controller: _pageController),

          _myDotsIndicator 
         ],
       ));
     }
   
     scrollToPage(double double) {

     }
}