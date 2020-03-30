import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myapp/utils/screen_type.dart';

double _width=0; 
const _paths = [
    'https://biobrix-files.s3.ap-south-1.amazonaws.com/images/dry-skin-tips.png',
    'https://biobrix-files.s3.ap-south-1.amazonaws.com/images/oily_face.webp',
    'https://biobrix-files.s3.ap-south-1.amazonaws.com/images/hair_care.jpg',
    'https://biobrix-files.s3.ap-south-1.amazonaws.com/images/sun-protection.jpg'
  ];

const _names = [
    'Dry Skin',
    'Oily Skin',
    'Hair Care',
    'Sun Protection'
];

const _icons = [
  FontAwesomeIcons.water,
  FontAwesomeIcons.surprise,
  FontAwesomeIcons.stumbleuponCircle,
  FontAwesomeIcons.sun
];
var _hoverPos = -1;

class SkinTypeProductsView extends StatefulWidget {

  SkinTypeProductsView({
    @required this.screentype 
  });

  final DeviceScreenType screentype;

  @override
  _SkinTypeProductsView createState() => _SkinTypeProductsView();

  

}

class _SkinTypeProductsView extends State<SkinTypeProductsView> with TickerProviderStateMixin{
  
  Animation<double> _scaleAnimation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    initAnimation();
  }

  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

    _width = MediaQuery.of(context).size.width;
    return  Container(
       //color: Color(0x66F167FA),
       child: Column(
       children: <Widget>[
       SizedBox(height: 30),
       Center(child: Padding(
         padding: const EdgeInsets.all(8.0),
         child: Text('ALL TYPE OF BODY CARE PRODUCTS',style: TextStyle(fontSize: 26),),
       ),),
       SizedBox(height: 30),

       widget.screentype == DeviceScreenType.Desktop? _getWebView(): _getMobileView(widget.screentype),

       SizedBox(height: 30),
       ],),
       );

  }
      
  _getWebView(){
    var width = _width/5;
    return  Row(
       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
       children: <Widget>[
        Padding(padding: const EdgeInsets.all(8),child: _getWidget(0,width),),
        Padding(padding: const EdgeInsets.all(8),child: _getWidget(1,width),),
        Padding(padding: const EdgeInsets.all(8),child: _getWidget(2,width),),
        Padding(padding: const EdgeInsets.all(8),child: _getWidget(3,width),),
       ],);
  }

  _getMobileView(DeviceScreenType deviceScreenType) {
    var width = deviceScreenType == DeviceScreenType.Mobile ? _width/2 : _width/3;
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.spaceAround,
      children: <Widget>[
        _getWidget(0,width,height: 200),
        _getWidget(1,width,height: 200),
        _getWidget(2,width,height: 200),
        _getWidget(3,width,height: 200),
      ],
    );
  }
      
  _getWidget(int pos,double width,{double height = 200}) {
    return MouseRegion(
    child: SizedBox(
    width: width,
    height: height,
    child: Stack(
    children: <Widget>[
    Image.network(_paths[pos],height: 200,fit: BoxFit.fill),
    _hoverPos == pos ? Container(
    color: Colors.black45,
    child: Center(
    child: ScaleTransition(
          scale: _scaleAnimation,
          child: Column(children: <Widget>[
          Spacer(),
          FaIcon(_icons[pos],color: Colors.white,size: 40),
          Text(_names[pos],style: TextStyle(color: Colors.white,fontSize: 22)),
          Spacer(),
        ],),
    ),
    ),
    ) :Container(),
    
    ],
    ),),
    onEnter: (event){
        setHover(pos);
       _controller.reset();
       _controller.forward();
    },
    onExit: (event) => setHover(-1),
    );
  }
      
  void setHover(int hover){
        setState(() {
          _hoverPos = hover;
        });        
  }

  void initAnimation(){
    _controller = AnimationController(duration: Duration(milliseconds: 200),vsync: this);
    _scaleAnimation = new Tween(begin: 1.0,end: 1.5).animate(_controller);

  }  

}
