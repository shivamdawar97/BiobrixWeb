import 'package:flutter/material.dart';
import 'package:myapp/config/config.dart';
import 'package:myapp/models/categoty.dart';
import 'package:myapp/models/product.dart';
import 'package:myapp/pages/homeContents/home_contents.dart';
import 'package:myapp/pages/homePage/homeRepository.dart';
import 'package:myapp/pages/productsPage/products_page.dart';
import 'package:myapp/utils/MyMouseRegion.dart';
import 'package:myapp/utils/responsive_builder.dart';
import 'package:myapp/utils/screen_type.dart';
import 'package:myapp/views/drawer_view.dart';
import 'package:myapp/views/header_view.dart';
import 'package:myapp/views/top_view.dart';

List<bool> _showMenu = [false,false];
List<double> _menuPos = [0,0];


ScrollController _scrollController;
bool _homeView = true;
Widget _containerWidget;
DeviceScreenType _screenType;

class MyHomePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  final HomeRepository repo= new HomeRepository();

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{

  List<HomeProduct> _products;
  List<Category> _categories;
  Animation<double> _scaleAnimation,_scaleAnimation2;
  AnimationController _animController;
  List<Widget> _menus =[];

  @override
  void initState() {
    super.initState();
    _getProducts();
    _getCategories();
    initAnimation();
    _scrollController= ScrollController();

    _scrollController.addListener(() { 
      if(_scrollController.offset>30)
         _animController.forward();
      else _animController.reset();   
    });

    _menus.add(_getMenu(0));
    _menus.add(Container());
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
    _scaleAnimation2 = new Tween(begin: 1.0,end: 0.6).animate(_animController);

  }
      
      @override
      Widget build(BuildContext context) {
        
        return ResponsiveBuilder(builder: (context,sizingInfo){
          _screenType = sizingInfo.deviceScreenType;
          return Scaffold(
            key: widget._scaffoldKey,
            drawer: sizingInfo.deviceScreenType == DeviceScreenType.Mobile? SideDrawer():null,
            body: Column(children: <Widget>[
              SizeTransition(sizeFactor: _scaleAnimation,child: TopView(),),
              SizeTransition(sizeFactor: _scaleAnimation2,child: HeaderView(context,scaffoldKey: widget._scaffoldKey,
                onProductViewtHover: (show,dx)=> _setMenuState(show,0,dx: dx),
                onProductRangetHover: (show,dx)=> _setMenuState(show,1,dx: dx),
                screentype: sizingInfo.deviceScreenType,
                ),),
              Expanded(
                flex: 1,
                child: Container(
                decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/web_bg.jpg'),fit: BoxFit.fill)),
                child: Stack(
                 children: <Widget>[
                   _homeView
                ? SingleChildScrollView(  
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                child: Stack(
                  overflow: Overflow.clip,
                  children: <Widget>[
                    HomeContents(products: _products,tetimonies: widget.repo.getTestimonies(),sizingInfo: sizingInfo,),
                  ],
                ),)
                : _containerWidget,
                _showMenu[0]? _getPositionedMenu(0):Container(),
                _showMenu[1]? _getPositionedMenu(1):Container(),
                 ], 
                )
              ),
              ),
            ],)
          );
        });
      }
                        
    void _setMenuState(bool show,int which,{double dx,double dy}) {
      if(dx!=null) _menuPos[which] = dx; 
       setState(() {
         _showMenu[which] = show;
       });
    }

    _getMenu(int pos) {
      List<Widget> menu = [];
      if(pos==0){
        menu.add(FlatButton(onPressed: (){}, child: Text('Biobrix Products')));
        menu.add(FlatButton(onPressed: (){}, child: Text('Demmacos Products')));
        menu.add(FlatButton(onPressed: (){}, child: Text('Professional Range')));
      } 
      else {
        _categories.asMap().forEach((i,element) =>
          menu.add(FlatButton(onPressed: (){
            appContainer.style.cursor = 'default';
            _onCategoryClicked(i);
          } , child: Text(element.name)))
        );
      }
      return MyMouseRegion(
          child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8))     
          ),
          child: Column(children: menu,)  
          ),
          onEnter: ()=> _setMenuState(true,pos),
          onExit: ()=> _setMenuState(false,pos),
        );
    }

    _getPositionedMenu(int pos){
    return Positioned(
        top: _scrollController.hasClients? _scrollController.offset: 0,
        left: _menuPos[pos],
        child: _menus[pos],
     );
    }
    
    void _getProducts() async {
      final ps = await widget.repo.callApi();
      if(ps!=null) setState((){_products=ps;});
    }

    void _getCategories() async {
      final cats = await widget.repo.getCategories();
      if(cats!=null) {
        _categories = cats;
        _menus[1]= _getMenu(1);
      };
    }

    void _onCategoryClicked(int pos){
        _setMenuState(false, 1);
        _containerWidget = ProductsPage(_categories,pos,onCategorySelected: (pos){
          _onCategoryClicked(pos);
        },);
        setState(() {
          _homeView = false;
        });
    }

}

