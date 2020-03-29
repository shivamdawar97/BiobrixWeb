import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/models/product.dart';
import 'package:myapp/pages/homePage/homeRepository.dart';
import 'package:myapp/utils/responsive_builder.dart';
import 'package:myapp/utils/screen_type.dart';
import 'package:myapp/utils/size_info.dart';
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

class _MyHomePageState extends State<MyHomePage> {

  Future<List<HomeProduct>> futureProducts;
  List<HomeProduct> products;  

  @override
  void initState() {
    super.initState();
    getProducts();

  }
      
      @override
      Widget build(BuildContext context) {
        HeaderView headerView = HeaderView(parentContext: context,scaffoldKey: widget._scaffoldKey,
                      onProductWidgetHover: (show,offset)=> _setProductMenuState(show,offset));
       
        return ResponsiveBuilder(builder: (context,sizingInfo){
          return Scaffold(
            key: widget._scaffoldKey,
            drawer: sizingInfo.deviceScreenType == DeviceScreenType.Mobile? SideDrawer():null,
            body: Container(
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/web_bg.jpg'),fit: BoxFit.fill)),
              child: SingleChildScrollView(    
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              child: Stack(
                children: <Widget>[
                Column(    
                children: <Widget>[
                        TopView(),
                        headerView,
                        ViewPager(),
                        SkinTypeProductsView(screentype: sizingInfo.deviceScreenType),
                        products==null? Container(): RecentProductsView(sizingInfo.deviceScreenType,products),
                        CustomerSays(widget.repo.getTestimonies()),
                        BottomView()
                          ],),
                        _showProductMenu? _getPositionedMenu():Container(),

                ],
              ),
              ),
            )
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
        top: _menuPosition.dy + (_showAppbar ? _scrollController.offset-50 : 25) ,
        left: _menuPosition.dx+30,
        child: MouseRegion(
          child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8))     
          ),
          child: Column(children: <Widget>[
              FlatButton(onPressed: (){}, child: Text('Biobrix Products')),
              FlatButton(onPressed: (){}, child: Text('Biobrix Haircare')),
              FlatButton(onPressed: (){}, child: Text('Professional Range')), 
            ],),
          ),
          onHover: (_)=>_setProductMenuState(true,_menuPosition),
          onExit: (_)=>_setProductMenuState(false,_menuPosition),
        ),
     );
    }
    
      _getRecentsView(SizingInformation info) {
        return FutureBuilder<List<HomeProduct>>(
          future: futureProducts,
          builder: (ctx,snapshot){
          if(snapshot.hasData) return RecentProductsView(info.deviceScreenType,snapshot.data);
          else return Text('Loading...');
        });
      }
    
      void getProducts() async {
        final ps = await widget.repo.callApi();
        if(ps!=null) setState((){products=ps;});
      }

}
