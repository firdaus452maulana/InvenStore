import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class orderTab extends StatefulWidget {
  @override
  _orderTabState createState() => _orderTabState();
}

class _orderTabState extends State<orderTab> {

  DatabaseReference _reference, _ref;
  Query _queryOrder;
  String _namaItem, _urlItem, _jumlahItem, _date, _namaPembeli, _alamatPembeli, valueStatus, soldOut;
  int _soldOut;

  List status = ["Menunggu", "Diperiksa", "Batal", "Terkirim"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _reference = FirebaseDatabase.instance.reference().child('listOrder');
    _ref = FirebaseDatabase.instance.reference().child('common');
    _queryOrder = FirebaseDatabase.instance.reference().child('listOrder').orderByChild('tanggal');
    getStockSoldDetail();
  }

  Widget _buildListOrder({Map order}){
    Color statusColor = getStatusColor(order['status']);

    return GestureDetector(
      onTap: (){
        if (order['status'] != 'Terkirim')
          _showDialogStatus(order['key']);
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
                  child: order['url'] != null
                      ? Image.network(order['url'], fit: BoxFit.fill,)
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
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              order['tanggal'],
                              style: GoogleFonts.openSans(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12
                              ),
                            ),
                          ),

                          SizedBox(width: 8,)  ,

                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              order['status'],
                              style: GoogleFonts.openSans(
                                  color: statusColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 4,)  ,

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          order['nama item'],
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),
                        ),
                      ),

                      SizedBox(height: 8,)  ,

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '@' + order['nama pembeli'],
                          style: GoogleFonts.openSans(
                              color: Color(0xFFFF1F69),
                              fontWeight: FontWeight.normal,
                              fontSize: 16
                          ),
                        ),
                      ),

                      SizedBox(height: 4,)  ,

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          order['alamat pembeli'],
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 12
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }

  Widget _showDialogStatus(String orderKey){
    getOrderDetail(orderKey: orderKey);
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
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: _urlItem != null
                                        ? Image.network(_urlItem, fit: BoxFit.fill)
                                        : Image.network('https://upload.wikimedia.org/wikipedia/commons/0/0a/No-image-available.png', fit: BoxFit.fill),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(12),
                                    child: Column(
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: _date != null
                                            ? Text(
                                            _date,
                                            style: GoogleFonts.openSans(
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 12
                                            ),
                                          )
                                          : Text(
                                            "Loading...",
                                            style: GoogleFonts.openSans(
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 12
                                            ),
                                          ),
                                        ),

                                        SizedBox(height: 4,)  ,

                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: _namaItem != null
                                            ? Text(
                                            _namaItem,
                                            style: GoogleFonts.openSans(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16
                                            ),
                                          )
                                          : Text(
                                            'Loading...',
                                            style: GoogleFonts.openSans(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16
                                            ),
                                          )
                                        ),

                                        SizedBox(height: 4,)  ,

                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: _jumlahItem != null
                                          ? Text(
                                            _jumlahItem + ' lusin',
                                            style: GoogleFonts.openSans(
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16
                                            ),
                                          )
                                          : Text(
                                            'Loading...',
                                            style: GoogleFonts.openSans(
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              )
                            ],
                          ),

                          SizedBox(height: 8,),

                          Align(
                            alignment: Alignment.centerLeft,
                            child: _namaPembeli != null
                            ? Text(
                              _namaPembeli,
                              style: GoogleFonts.openSans(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),
                            )
                            : Text(
                              'Loading...',
                              style: GoogleFonts.openSans(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),
                            ),
                          ),

                          SizedBox(height: 4,),

                          Align(
                            alignment: Alignment.centerLeft,
                            child: _alamatPembeli != null
                            ? Text(
                              _alamatPembeli,
                              style: GoogleFonts.openSans(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12
                              ),
                            )
                            : Text(
                              'Loading...',
                              style: GoogleFonts.openSans(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12
                              ),
                            ),
                          ),

                          SizedBox(height: 4,),

                          DropdownButtonFormField(
                            icon: Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: Color(0xFF000000).withOpacity(0.25),
                                size: 20,
                              ),
                            ),
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide(
                                        color: Color(0xFF000000)
                                            .withOpacity(0.15))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                    borderSide:
                                    BorderSide(color: Color(0xFF031F4B))),
                                filled: false,
                                contentPadding:
                                EdgeInsets.only(left: 24.0, right: 0),
                                hintStyle: GoogleFonts.openSans(
                                    fontSize: 12,
                                    color: Color(0xFF000000).withOpacity(
                                        0.25)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide(
                                        color: Colors.red)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 1)),
                                errorStyle: GoogleFonts.openSans(
                                    fontSize: 10)),
                            hint: Text(
                              "Status",
                              style: GoogleFonts.openSans(
                                  fontSize: 12,
                                  color: Color(0xFF000000).withOpacity(.25)),
                            ),
                            value: valueStatus,
                            onChanged: (newValue) {
                              setState(() {
                                valueStatus = newValue;
                              });
                            },
                            validator: (value) {
                              if (valueStatus == null) {
                                return "Status harus dipilih!";
                              }
                              return null;
                            },
                            items: status.map((valueItem) {
                              return DropdownMenuItem(
                                value: valueItem,
                                child: Text(
                                  valueItem,
                                  style: GoogleFonts.openSans(
                                      fontSize: 12, color: Color(0xFF000000)),
                                ),
                              );
                            }).toList(),
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
                                "Update",
                                style: GoogleFonts.openSans(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12
                                ),
                              ),
                            ),
                            onPressed: () {
                              updateOrder(orderKey);
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
                  "Order",
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
            margin: EdgeInsets.only(top: 54),
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[

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
                        query: _queryOrder,
                        itemBuilder: (
                            BuildContext context,
                            DataSnapshot snapshot,
                            Animation<double> animation,
                            int index
                            ) {
                          Map item = snapshot.value;
                          item['key'] = snapshot.key;
                          return _buildListOrder(order: item);
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

  void getOrderDetail({String orderKey}) async {
    DataSnapshot snapshot = await _reference.child(orderKey).once();

    Map order = snapshot.value;

    _namaItem = order['nama item'];
    _jumlahItem = order['jumlah item'];
    _date = order['tanggal'];
    _urlItem = order['url'];
    _namaPembeli = order['nama pembeli'];
    _alamatPembeli = order['alamat pembeli'];
    valueStatus = order['status'];


    setState(() {});
  }

  getStockSoldDetail() async {
    DataSnapshot snapshot = await _ref.once();

    Map common = snapshot.value;

    soldOut = common['sold out'];

    _soldOut = int.parse(soldOut);

    setState(() {});
  }

  void justReset() {
    _namaItem = null;
    _jumlahItem = null;
    _date = null;
    _urlItem = null;
    _namaPembeli = null;
    _alamatPembeli = null;
    valueStatus = null;
  }

  Color getStatusColor(String status) {
    Color color = Theme
        .of(context)
        .accentColor;

    if (status == 'Terkirim') {
      color = Color(0xFF628C57);
    }
    if (status == 'Batal') {
      color = Color(0xFFFF6A6A);
    }
    if (status == 'Diperiksa') {
      color = Color(0xFFFFD54F);
    }
    if (status == 'Menunggu') {
      color = Colors.black;
    }
    return color;
  }

  void updateOrder(String orderKey) {
    Map<String, String> status = {
      'status': valueStatus,
    };

    if (valueStatus == 'Terkirim')
      {
        _soldOut = int.parse(soldOut);
        int tambahSoldOut = int.parse(_jumlahItem);
        _soldOut += tambahSoldOut;

        Map<String,String> common = {
          'sold out' : _soldOut.toString(),
        };

        _ref.update(common);
      }

    _reference.child(orderKey).update(status).then((value) {
      justReset();
      Navigator.pop(context);
      setState(() {});
    });
  }
}


