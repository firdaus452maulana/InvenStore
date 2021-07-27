import 'package:dicoding_submission_flutter/AddPage/addOrder.dart';
import 'package:dicoding_submission_flutter/AddPage/addStock.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class stockTab extends StatefulWidget {
  @override
  _stockTabState createState() => _stockTabState();
}

class _stockTabState extends State<stockTab> {

  DatabaseReference _reference;
  Query _query;
  String _namaItem, _hargaItem, _urlItem;
  int _jumlahItem, _jumlahSoldOOut;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _reference = FirebaseDatabase.instance.reference().child('listItem');
    _query = FirebaseDatabase.instance.reference().child('listItem').orderByChild('nama');
  }

  Widget _buildListItem({Map item}){
    return GestureDetector(
      onTap: (){
        _showDialogOrder(item['key']);
      },
      child: Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 16),
        padding: EdgeInsets.only(bottom: 12, right: 12, top: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 2,
              blurRadius: 6,
              offset: Offset(0, 0),
            )
          ],
          borderRadius: BorderRadius.circular(17.5),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
                child: Container(
                  height: 100,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: item['url'] != null
                    ? Image.network(item['url'], fit: BoxFit.fill,)
                    : Image.network('https://upload.wikimedia.org/wikipedia/commons/0/0a/No-image-available.png', fit: BoxFit.fill),
                  ),
                ),
            ),
            Expanded(
              flex: 3,
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(12),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          item['nama'],
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),
                        ),
                      ),

                      SizedBox(height: 4,)  ,

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'IDR. ' + item['harga'],
                          style: GoogleFonts.openSans(
                              color: Color(0xFFFF1F69),
                              fontWeight: FontWeight.normal,
                              fontSize: 16
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }

  Widget _showDialogOrder(String itemKey){
    getItemDetail(itemKey: itemKey);
    showDialog(
        context: context,
        builder: (context){
          return Dialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              margin: EdgeInsets.all(24),
              child: SingleChildScrollView(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          top: 16, bottom: 16, left: 8, right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        //posisi
                        mainAxisSize: MainAxisSize.min,
                        // untuk mengatur agar widget column mengikuti widget
                        children: <Widget>[
                          Container(
                            height: 300,
                            width: 300,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: _urlItem != null
                                  ? Image.network(_urlItem, fit: BoxFit.fill)
                                  : Image.network('https://upload.wikimedia.org/wikipedia/commons/0/0a/No-image-available.png', fit: BoxFit.fill),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _namaItem,
                              style: GoogleFonts.openSans(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'IDR. ' + _hargaItem,
                              style: GoogleFonts.openSans(
                                  color: Color(0xFFFF1F69),
                                  fontWeight: FontWeight.normal,
                                  fontSize: 20
                              ),
                            ),
                          ),

                          SizedBox(height: 8,),

                          RaisedButton(
                            color: Color(0xFF1F3A93),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            textColor: Colors.white,
                            child: Container(
                              padding: EdgeInsets.all(12),
                              alignment: Alignment.center,
                              child: Text(
                                "Order",
                                style: GoogleFonts.openSans(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => addOrderPage(itemKey: itemKey,)));
                            },
                          )
                        ],
                      ),
                    ),

                    Positioned(
                      right: 0.0,
                      child: GestureDetector(
                        onTap: () {
                          justReset();
                          Navigator.pop(context);
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: Color(0xFF1F3A93),
                            child: Icon(
                              Icons.close,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

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
                            _jumlahItem.toString(),
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
                    padding: EdgeInsets.only(top: 64),
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
                    child: CupertinoScrollbar(
                      child: FirebaseAnimatedList(
                        query: _query,
                        itemBuilder: (
                            BuildContext context,
                            DataSnapshot snapshot,
                            Animation<double> animation,
                            int index
                        ) {
                          Map item = snapshot.value;
                          item['key'] = snapshot.key;
                          return _buildListItem(item: item);
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  getItemDetail({String itemKey}) async {
    DataSnapshot snapshot = await _reference.child(itemKey).once();

    Map item = snapshot.value;

    _namaItem = item['nama'];
    _hargaItem = item['harga'];
    _urlItem = item['url'];

  }

  justReset() {
    _namaItem = null;
    _hargaItem = null;
    _urlItem = null;
  }
}
