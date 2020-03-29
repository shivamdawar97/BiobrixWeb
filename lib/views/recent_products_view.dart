import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/cards/product_card.dart';
import 'package:myapp/models/product.dart';
import 'package:myapp/utils/my_dots_indicator.dart';
import 'package:myapp/utils/screen_type.dart';

double _width = 0;
PageController _pageController;
MyDotsIndicator _myDotsIndicator;

class RecentProductsView extends StatelessWidget {

  RecentProductsView(this._screenType,this._products);

  final DeviceScreenType _screenType;
  final List<HomeProduct> _products;
  final controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    _pageController = PageController();  
    _width = MediaQuery.of(context).size.width;
    
    Widget w;
    switch (_screenType) {
        case DeviceScreenType.Desktop: w = _getWebView(); break;
        case DeviceScreenType.Tablet: w = _getTabletView(); break;
        default: w = _getMobileView(); 
     }
    return Container(
      decoration: BoxDecoration(color: Colors.grey[100]),
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Center(child: Text('RECENT PRODUCTS',style: TextStyle(fontSize: 28),),),
          Center(child: Container(height: 2,width: 100,color: Colors.black,),),
          SizedBox(height: 50,),
          Stack(children: <Widget>[
            
            SizedBox(height: 400, child: w,),

            SizedBox(
              height: 400,
              child: Align(alignment: Alignment.centerLeft,
              child: IconButton(icon: Icon(Icons.chevron_left,size: 40),
               onPressed: () => scrollToPage(_pageController.page-1)
              ),),
            ),

            SizedBox(
              height: 400,
              child: Align(alignment: Alignment.centerRight,
              child: IconButton(icon: Icon(Icons.chevron_right,size: 40,), 
              onPressed: ()=> scrollToPage(_pageController.page+1)),),
            ),

          ],),
          _myDotsIndicator,
          SizedBox(height: 50,),
        ],
      )
    );
  }

  Widget _getWebView(){
    
    final width = _width/5;
    
    final List<Widget> pages = [];
    for(int i=0; i<_products.length;i+=4){
      final List<Widget> widgets= [];
      widgets.add(ProductCard(_products[i], width, 600));
      if(_products.length-1>=i+1) widgets.add(ProductCard(_products[i+1], width, 600));
      if(_products.length-1>=i+2) widgets.add(ProductCard(_products[i+2], width, 600));
      if(_products.length-1>=i+3) widgets.add(ProductCard(_products[i+3], width, 600));
      
      final page = Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widgets);
      pages.add(page);
    }
    _myDotsIndicator = MyDotsIndicator(dots:pages.length,
   onSelected: (page) => scrollToPage(page.toDouble()),);
    return PageView(children: pages,controller: _pageController,);

  }

  Widget _getTabletView(){

    final width = _width/2.5;
    final List<Widget> pages = [];
    for(int i=0; i<_products.length;i+=2){
      final List<Widget> widgets= [];
      widgets.add(ProductCard(_products[i], width, 500));
      if(_products.length-1>=i+1) widgets.add(ProductCard(_products[i+1], width, 500));
      final page = Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widgets);
      pages.add(page);
    }
      _myDotsIndicator = MyDotsIndicator(dots:pages.length,
   onSelected: (page) => scrollToPage(page.toDouble()),);
    return PageView(children: pages,controller: _pageController,);
  }

  Widget _getMobileView(){

       _myDotsIndicator = MyDotsIndicator(dots:_products.length,
       onSelected: (page) => scrollToPage(page.toDouble()),);
      return PageView.builder(itemBuilder: (ctx,pos){
      return ProductCard(_products[pos], _width-20, 150);
      },itemCount: _products.length,controller: _pageController);
  }

   void scrollToPage(double page,{int milliseconds = 400}){
      _pageController.animateToPage(page.toInt(),duration: Duration(milliseconds: milliseconds),curve: Curves.decelerate);
       _myDotsIndicator.setCurrentPage(page.toInt());
  }

}

