import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/utils/MyMouseRegion.dart';
import 'package:myapp/utils/screen_type.dart';

typedef void OnWidgetHover(bool show,double position);

int _hoverPos = -1;
final _widgetsNames = [
    'About Us','Products','Products Range','Trade Inquiry','Contact Us'
  ];

class HeaderView extends StatefulWidget implements PreferredSizeWidget  {

  const HeaderView(this.parentContext,{
    this.scaffoldKey,
    this.onProductViewtHover,
    this.onProductRangetHover,
    this.screentype
  });

  final BuildContext parentContext;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final DeviceScreenType screentype;
  final OnWidgetHover onProductViewtHover;
  final OnWidgetHover onProductRangetHover;

  @override
  State<StatefulWidget> createState() => _HeaderViewState();

   @override
  Size get preferredSize{
    var mediaQuery = MediaQuery.of(parentContext);
    return mediaQuery.size;
  }
}


class _HeaderViewState extends State<HeaderView>  {
  
  final _dropDownKey1 = GlobalKey();
  final _dropDownKey2 = GlobalKey();
  double _x1,_x2;


  void _getDropDownPositions(){

    final box1 = _dropDownKey1.currentContext.findRenderObject() as RenderBox;
    final box2 = _dropDownKey2.currentContext.findRenderObject() as RenderBox;
    final pos = box1.localToGlobal(Offset.zero);
    _x1 = pos.dx;
    _x2 = box2.localToGlobal(Offset.zero).dx;

  }

  @override
  Widget build(BuildContext context) {
    return widget.screentype == DeviceScreenType.Desktop? _getWebUI() : _getMobileUI();
  }
                    
_getMobileUI() {

return Container(
  decoration: BoxDecoration(color: Colors.white),
  padding: EdgeInsets.all(10),
  child:   Row(
        children: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => widget.scaffoldKey.currentState.openDrawer()
            ),
            SizedBox(width: 5,),
            Text('BIOBRIX',style: GoogleFonts.actor(fontSize: 22.0,fontWeight: FontWeight.bold)
            ),
            Spacer(flex: 1,),
            _getSearchView(false),
        ],
  
    ),
);

}

_getWebUI() {

  return Container(
    decoration: BoxDecoration(color: Colors.white),
    padding: EdgeInsets.fromLTRB(50, 0, 30, 0),
    child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 5,bottom: 5),
              width: 150,height: 100,
              child: Image.asset('assets/logo.png',fit: BoxFit.fill,),),
            __getListWidget(0),
            __getListWidget(1),
            __getListWidget(2),
            __getListWidget(3),
            __getListWidget(4),
            _getSearchView(true),
            SizedBox(width: 1,)
        ],

    ),
  );

}

__getListWidget(int pos){
  final textView = Text(_widgetsNames[pos],style: TextStyle(fontSize: 18,color: pos==_hoverPos ?Colors.blue[400]:Colors.black));
   return Container(
      height: 100,
      key: pos==1?_dropDownKey1: pos==2? _dropDownKey2 : null,
      child: MyMouseRegion(child: 
      Center(child: (pos==1 || pos==2) 
        ? Row(children: <Widget>[textView,Icon(Icons.arrow_drop_down)],)
        : textView
      ),
      onTap: (){
        
      },
      onEnter: (){
          if(pos==1) {
            _getDropDownPositions();
            widget.onProductViewtHover(true,_x1);
          }
          else if(pos==2) {
            _getDropDownPositions();
            widget.onProductRangetHover(true,_x2);
          }
          _setHoverPosition(pos);
      },
      onExit: (){
          if(pos==1) widget.onProductViewtHover(false,_x1);
          else if(pos==2) widget.onProductRangetHover(false,_x2);
          _setHoverPosition(-1);
      },
      ));
}

_getSearchView(bool isWeb){
    return Container(
      width: isWeb? 200:100,
      height: isWeb?50:30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3)
      ),
      child:TextField(
        autofocus: false,
        inputFormatters: [LengthLimitingTextInputFormatter(isWeb?22:11)],
        style: TextStyle(fontSize: 12),
        decoration: InputDecoration(border:  OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        labelText: 'Search...',
      )),
      );
  }

 _setHoverPosition(int pos){
      setState(() {
        _hoverPos = pos;
      });
  }


}