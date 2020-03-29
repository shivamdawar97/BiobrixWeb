import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/config/config.dart';
import 'package:myapp/models/product.dart';

class ProductCard extends StatefulWidget {

  ProductCard(this.product,this.width,this.height);

  final HomeProduct product;
  final double width,height;

  @override
  State<StatefulWidget> createState() {
      product.productName = product.productName[0].toUpperCase()+ product.productName.substring(1);
      return _ProductCardState();
  }
       
}

class _ProductCardState extends State<ProductCard> with TickerProviderStateMixin{

  Animation<double> _scaleAnimation;
  AnimationController _controller;

   @override
  void initState() {
    super.initState();
    initAnimation();
  }
 void initAnimation(){
    _controller = AnimationController(duration: Duration(milliseconds: 200),vsync: this);
    _scaleAnimation = new Tween(begin: 1.0,end: 1.2).animate(_controller);

  } 

    @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.white
            ),
            width:widget.width,
            height: widget.height,
            child: Column(
              children: <Widget>[
                SizedBox(height: 10,),

                Expanded(child: ScaleTransition(scale: _scaleAnimation,
                child: Image.network(widget.product.image,fit: BoxFit.fill,),),flex: 1,),
                
                SizedBox(height: 10,),
                
                Text(widget.product.productName,style: 
                TextStyle(fontSize: 20)),

                Text('₹ ${widget.product.price}',style: 
                TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),

                MouseRegion(child: 
                FlatButton(child: Text('Add to cart'),
                shape: RoundedRectangleBorder(side: BorderSide(color: Colors.red)),
                onPressed: (){}),
                onEnter: (_)=>appContainer.style.cursor = 'pointer',
                onExit: (_)=>appContainer.style.cursor = 'default'),


                MouseRegion(child: 
                FlatButton(child: Text('Add to Wishlist'),
                shape: RoundedRectangleBorder(side: BorderSide(color: Colors.red)),
                onPressed: (){}),
                onEnter: (_)=>appContainer.style.cursor = 'pointer',
                onExit: (_)=>appContainer.style.cursor = 'default'),

                SizedBox(height: 10,)

              ],),

      ),
      onEnter: (_)=>_controller.forward(), 
      onExit: (_)=>_controller.reset(), 
          );     
  }

}