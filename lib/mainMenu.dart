import 'package:dicoding_submission_flutter/AddPage/addStock.dart';
import 'package:dicoding_submission_flutter/Tab/orderTab.dart';
import 'package:dicoding_submission_flutter/Tab/partnershipTab.dart';
import 'package:dicoding_submission_flutter/Tab/stockTab.dart';
import 'package:dicoding_submission_flutter/Tab/stroreTab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class mainMenu extends StatefulWidget {
  @override
  _mainMenuState createState() => _mainMenuState();
}

class _mainMenuState extends State<mainMenu> with SingleTickerProviderStateMixin{
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    stockTab(),
    orderTab(),
    partnershipTab(),
    //storeTab()
  ];

  void _onItemTap(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animationIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _animationController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 500))
        ..addListener(() {
          setState(() {});
          });
    _animationIcon =
        Tween<double>(begin: 0.0, end: 1).animate(_animationController);
    _buttonColor =
        ColorTween(begin: Colors.blue, end: Colors.red).animate(
          CurvedAnimation(
              parent: _animationController,
              curve: Interval(0.0, 1, curve: Curves.linear))
        );
    _translateButton =
        Tween<double>(begin: _fabHeight, end: -14.0).animate(
          CurvedAnimation(
              parent: _animationController,
              curve: Interval(0.0, 0.75, curve: _curve))
        );
    super.initState();
  }

  //Tombol Floating Button
  Widget addStockButton(){
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => addStockPage()));
        },
        tooltip: "Add Stock",
        child: Icon(Icons.storage),
      ),
    );
  }

  Widget addOrderButton(){
    return Container(
      child: FloatingActionButton(
        onPressed: (){},
        tooltip: "Add Order",
        child: Icon(Icons.sticky_note_2_outlined),
      ),
    );
  }

  Widget addPartnershipButton(){
    return Container(
      child: FloatingActionButton(
        onPressed: (){},
        tooltip: "Add Partnership",
        child: Icon(Icons.account_tree),
      ),
    );
  }

  Widget addStoreButton(){
    return Container(
      child: FloatingActionButton(
        onPressed: (){},
        tooltip: "Add Store",
        child: Icon(Icons.store),
      ),
    );
  }

  Widget buttonToggle(){
    return Container(
      child: FloatingActionButton(
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: "Toggle",
        child: AnimatedIcon(icon: AnimatedIcons.menu_close, progress: _animationIcon,),
      ),
    );
  }

  animate(){
    if(!isOpened)
      _animationController.forward();
    else
      _animationController.reverse();
    isOpened = !isOpened;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      // floatingActionButton: Column(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: <Widget>[
      //     Transform(transform: Matrix4.translationValues(0, _translateButton.value*4.0, 0),
      //       child: Container(
      //         child: FloatingActionButton(
      //           onPressed: () {
      //             Navigator.push(
      //                 context, MaterialPageRoute(builder: (context) => addStockPage()));
      //           },
      //           tooltip: "Add Stock",
      //           child: Icon(Icons.storage),
      //         ),
      //       ),
      //     ),
      //     Transform(transform: Matrix4.translationValues(0, _translateButton.value*3.0, 0),
      //       child: addOrderButton(),
      //     ),
      //     Transform(transform: Matrix4.translationValues(0, _translateButton.value*2.0, 0),
      //       child: addPartnershipButton(),
      //     ),
      //     Transform(transform: Matrix4.translationValues(0, _translateButton.value, 0),
      //       child: addStoreButton(),
      //     ),
      //     buttonToggle()
      //   ],
      // ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.storage),
            title: Text('Stock'),
            //backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sticky_note_2_outlined),
            title: Text('Order'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_tree),
            title: Text('Partnership'),
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.store),
          //   title: Text('Store'),
          // )
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}
