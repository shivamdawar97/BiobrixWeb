import 'package:flutter/material.dart';
import 'package:myapp/models/product.dart';
import 'package:myapp/pages/homeContents/home_contents.dart';
import 'package:myapp/pages/homePage/homeRepository.dart';
import 'package:myapp/utils/responsive_builder.dart';
import 'package:myapp/utils/screen_type.dart';
import 'package:myapp/views/ViewPager.dart';
import 'package:myapp/views/bottom_part.dart';
import 'package:myapp/views/customer_says.dart';
import 'package:myapp/views/drawer_view.dart';
import 'package:myapp/views/header_view.dart';
import 'package:myapp/views/recent_products_view.dart';
import 'package:myapp/views/skin_type_view.dart';
import 'package:myapp/views/top_view.dart';

bool _showProductMenu = false;
Offset _menuPosition;
ScrollController _scrollController;
bool _showAppbar = false;

class MyHomePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  final HomeRepository repo= new HomeRepository();

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{

  Future<List<HomeProduct>> futureProducts;
  List<HomeProduct> products;  
  Animation<double> _scaleAnimation;
  AnimationController _animController;
  
  @override
  void initState() {
    super.initState();
    getProducts();
    initAnimation();
    _scrollController= ScrollController();

    _scrollController.addListener(() { 
      if(_scrollController.offset>30)
         _animController.forward();
      else _animController.reset();   
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _animController.dispose();
  }

  void initAnimation(){
    _animController = AnimationController(duration: Duration(milliseconds: 200),vsync: this);
    _scaleAnimation = new Tween(begin: 1.0,end: 0.0).animate(_animController);

  }
      
      @override
      Widget build(BuildContext context) {

        HeaderView headerView = HeaderView(parentContext: context,scaffoldKey: widget._scaffoldKey,
                      onProductWidgetHover: (show,offset)=> _setProductMenuState(show,offset));
       
        return ResponsiveBuilder(builder: (context,sizingInfo){
          return Scaffold(
            key: widget._scaffoldKey,
            drawer: sizingInfo.deviceScreenType == DeviceScreenType.Mobile? SideDrawer():null,
            body: Column(children: <Widget>[
              SizeTransition(sizeFactor: _scaleAnimation,child: TopView(),),
              headerView,
              Expanded(
                flex: 1,
                child: Container(
                decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/web_bg.jpg'),fit: BoxFit.fill)),
                child: SingleChildScrollView(  
                physics: ScrollPhysics(),    
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                child: Stack(
                  overflow: Overflow.clip,
                  children: <Widget>[
                  HomeContents(products: products,tetimonies: widget.repo.getTestimonies(),sizingInfo: sizingInfo,),
                  _showProductMenu? _getPositionedMenu():Container(),
                  ],
                ),
                ),
            ),
              ),
              
            ],)
          );
        });
      }
                        
    void _setProductMenuState(bool show,Offset position) {
      _menuPosition = position;
       setState(() {
         _showProductMenu = show;
       });
    }
    
    // _getPoductsMenu(){
    //  return OverlayEntry(builder: (context)=>_getPositionedMenu());
    // }
    
    _getPositionedMenu(){
    return Positioned(
        top: _scrollController.offset -10 ,
        left: _menuPosition.dx+30,
        child: MouseRegion(
          child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8))     
          ),
          child: Column(children: <Widget>[
              FlatButton(onPressed: (){}, child: Text('Biobrix Products')),
              FlatButton(onPressed: (){}, child: Text('DEMMACOS Products')),
              FlatButton(onPressed: (){}, child: Text('Professional Range')), 
            ],),
          ),
          onHover: (_)=>_setProductMenuState(true,_menuPosition),
          onExit: (_)=>_setProductMenuState(false,_menuPosition),
        ),
     );
    }
    
      void getProducts() async {
        final ps = await widget.repo.callApi();
        if(ps!=null) setState((){products=ps;});
      }

}

