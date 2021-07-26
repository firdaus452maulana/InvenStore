import 'package:dicoding_submission_flutter/addStock.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class stockTab extends StatefulWidget {
  @override
  _stockTabState createState() => _stockTabState();
}

class _stockTabState extends State<stockTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        height: 48,
        width: 48,
        margin: EdgeInsets.only(bottom: 12, left: 12, right: 6),
        child: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Color(0xFF00A5FF),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => addStockPage()));
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.05, 0.5],
                    colors: [Color(0xFF79CAF6), Color(0xFF2E9EDA)]
                )
            ),
          ),
          Positioned(
            child: PreferredSize(
              preferredSize: Size.fromHeight(56),
              child: AppBar(
                title: Text(
                  "Stocks",
                  style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: InkWell(
                      child: CircleAvatar(
                        backgroundImage: AssetImage('images/pp.jpg'),
                      ),
                      onTap: (){},
                    ),
                  )
                ],
                centerTitle: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 108),
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 16, bottom: 16, right: 20, left: 20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            stops: [0.05, 0.75],
                            colors: [Color(0xFFFF99BB), Color(0xFFFF70A0)]
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            spreadRadius: 2,
                            blurRadius: 6,
                            offset: Offset(0, 4),
                          )
                        ],
                        borderRadius: BorderRadius.circular(17.5),
                      ),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Item",
                            style: GoogleFonts.openSans(
                                color: Colors.white70,
                                fontSize: 12,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "2000000",
                            style: GoogleFonts.openSans(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16,),
                    Container(
                      padding: EdgeInsets.only(top: 16, bottom: 16, right: 20, left: 20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [0.05, 0.5],
                            colors: [Color(0xFF5079FF), Color(0xFF1F3A93)]
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            spreadRadius: 2,
                            blurRadius: 6,
                            offset: Offset(0, 4),
                          )
                        ],
                        borderRadius: BorderRadius.circular(17.5),
                      ),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Sold Out",
                            style: GoogleFonts.openSans(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "2000000",
                            style: GoogleFonts.openSans(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16,),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 32),
                    padding: EdgeInsets.all(0),
                    //height: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xFFFAFAFA),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: Offset(0, 4)
                        )
                      ],
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(64),
                        topLeft: Radius.circular(64),
                        bottomRight: Radius.circular(0),
                        bottomLeft: Radius.circular(0),
                      ),
                    ),
                    child: Text("Test"),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
