import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/config/config.dart';
import 'package:myapp/utils/MyMouseRegion.dart';
import 'package:myapp/utils/responsive_builder.dart';
import 'package:myapp/utils/screen_type.dart';

typedef void OnProductWidgetHover(bool show,Offset position);

class HeaderView extends StatelessWidget implements PreferredSizeWidget  {
  
  final BuildContext parentContext;
  final GlobalKey<ScaffoldState> scaffoldKey;
  HeaderView({
    this.parentContext,
    this.scaffoldKey,
    this.onProductWidgetHover
  });
  final OnProductWidgetHover onProductWidgetHover;

  final widgets = <Widget>[
    Text('About Us',style: TextStyle(fontSize: 18),),
    Text('Trade Enquiry',style: TextStyle(fontSize: 18)),
    Text('Contact Us',style: TextStyle(fontSize: 18))
  ];



  @override
  Widget build(BuildContext context) {
    
    return ResponsiveBuilder(
      builder: (context,sizingInfo){
        return sizingInfo.deviceScreenType == DeviceScreenType.Desktop? _getWebUI() : _getMobileUI();
      },
    );
  }
                    
_getMobileUI() {

return Container(
  decoration: BoxDecoration(color: Colors.white),
  padding: EdgeInsets.all(10),
  child:   Row(
        children: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => scaffoldKey.currentState.openDrawer()
            ),
            SizedBox(width: 5,),
            Text('BIOBRIX',
            style: GoogleFonts.actor(fontSize: 22.0,fontWeight: FontWeight.bold)
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
    padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
    child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
            Text('BIOBRIX',
            style:GoogleFonts.sourceSerifPro(fontSize: 44.0,fontWeight: FontWeight.bold)
            ),
            SizedBox(width: 20,),
            __getListWidget(0),
            _ProductWidget(onProductWidgetHover: onProductWidgetHover,),
            __getListWidget(1),
            __getListWidget(2),
            _getSearchView(true),
            SizedBox(width: 20,)
        ],

    ),
  );

}

__getListWidget(int pos){
   return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MyMouseRegion(child: widgets[pos],
      onTap: (){
        
      },)
    );
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


  @override
  Size get preferredSize{
    var mediaQuery = MediaQuery.of(parentContext);
    return mediaQuery.size;
  }

} 

class _ProductWidget extends StatefulWidget {
  _ProductWidget({
    @required this.onProductWidgetHover
  });
  final OnProductWidgetHover onProductWidgetHover;

  @override
  State<StatefulWidget> createState() => _ProductWidgetState();

}

class _ProductWidgetState extends State<_ProductWidget> {
  
  final GlobalKey _widgetKey = GlobalKey();
  
  Offset _menuPosition;
  bool _isHover = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
       RenderBox _wid = _widgetKey.currentContext.findRenderObject();
    _menuPosition = _wid.localToGlobal(Offset.zero);
     });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
          children: <Widget>[
          MyMouseRegion(
          child: Row(
          key: _widgetKey,  
          children: <Widget>[
          Text('Product',style: TextStyle(fontSize: 18,color: _isHover?Colors.blue[400]:Colors.black)),
          Icon(Icons.arrow_drop_down,color:  _isHover?Colors.blue[400]:Colors.black,)
      ],),
        onEnter:() {
          showProductMenu(true);
          widget.onProductWidgetHover(true,_menuPosition);
        },
        onExit: (){
          showProductMenu(false);
          widget.onProductWidgetHover(false,_menuPosition);
        },
        ),
  ],
    );
  }

  showProductMenu(bool show){
      setState(() {
        _isHover = show;
      });
  }

}
