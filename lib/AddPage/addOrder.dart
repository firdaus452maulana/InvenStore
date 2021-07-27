import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class addOrderPage extends StatefulWidget {
  const addOrderPage({Key key, @required this.itemKey}) : super(key: key);

  final String itemKey;

  @override
  _addOrderPageState createState() => _addOrderPageState();
}

class _addOrderPageState extends State<addOrderPage> {

  TextEditingController _namaPembeliController,
      _alamatPembeliController,
      _jumlahItemController;
  String _namaItem, _hargaItem, _urlItem, _date, _time;
  DatabaseReference _reference, _referenceOrder, _ref;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _namaPembeliController = TextEditingController();
    _alamatPembeliController = TextEditingController();
    _jumlahItemController = TextEditingController();
    _reference = FirebaseDatabase.instance.reference().child('listItem');
    _referenceOrder = FirebaseDatabase.instance.reference().child('listOrder');
    _indogs();
    getItemDetail();
  }

  Future<void> _indogs() async {
    await initializeDateFormatting('id_ID', null);
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateFormat format = new DateFormat("EEEE, d LLLL yyyy", "id_ID");
    String formattedDate = format.format(now);

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
                  "Add Order",
                  style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                  ),
                ),
                centerTitle: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 108, left: 12, right: 12),
                  padding: EdgeInsets.only(left: 24, right: 24, top: 24),
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
                      topRight: Radius.circular(32),
                      topLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                      bottomLeft: Radius.circular(32),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        //posisi
                        mainAxisSize: MainAxisSize.min,
                        // untuk mengatur agar widget column mengikuti widget
                        children: <Widget>[

                          Text(
                            _date = formattedDate,
                            style: GoogleFonts.openSans(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                            ),
                          ),

                          Text(_time =
                          "${now.hour.toString()}:${now.minute
                              .toString().padLeft(2, '0')}"),

                          SizedBox(height: 12,),

                          Text(
                            "Informasi Pembeli",
                            style: GoogleFonts.openSans(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),

                          SizedBox(height: 12,),

                          // NAMA ITEM
                          Container(
                            child: TextFormField(
                              cursorColor: Colors.black,
                              style: GoogleFonts.openSans(fontSize: 12),
                              keyboardType: TextInputType.text,
                              controller: _namaPembeliController,
                              decoration: new InputDecoration(
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
                                      BorderSide(color: Color(0xFF1F3A93))),
                                  filled: false,
                                  contentPadding:
                                  EdgeInsets.only(left: 24.0, right: 24.0),
                                  hintStyle: GoogleFonts.openSans(
                                      fontSize: 12,
                                      color:
                                      Color(0xFF000000).withOpacity(0.15)),
                                  hintText: "Nama Pembeli",
                                  errorBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                      borderSide:
                                      BorderSide(color: Colors.red)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1)),
                                  errorStyle:
                                  GoogleFonts.openSans(fontSize: 10)),
                              obscureText: false,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Field is required";
                                }
                                return null;
                              },
                              onSaved: (value) {},
                            ),
                          ),
                          SizedBox(height: 12,),

                          // NAMA ITEM
                          Container(
                            child: TextFormField(
                              cursorColor: Colors.black,
                              style: GoogleFonts.openSans(fontSize: 12),
                              maxLines: 10,
                              controller: _alamatPembeliController,
                              decoration: new InputDecoration(
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
                                      BorderSide(color: Color(0xFF1F3A93))),
                                  filled: false,
                                  contentPadding: EdgeInsets.only(
                                      left: 24.0,
                                      right: 24.0,
                                      top: 12.0,
                                      bottom: 12.0),
                                  hintStyle: GoogleFonts.openSans(
                                      fontSize: 12,
                                      color:
                                      Color(0xFF000000).withOpacity(0.15)),
                                  hintText: "Alamat Pembeli",
                                  errorBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                      borderSide:
                                      BorderSide(color: Colors.red)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1)),
                                  errorStyle:
                                  GoogleFonts.openSans(fontSize: 10)),
                              obscureText: false,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Field is required";
                                }
                                return null;
                              },
                              onChanged: (value) {},
                            ),
                          ),

                          SizedBox(height: 12,),

                          Text(
                            "Informasi Item",
                            style: GoogleFonts.openSans(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),

                          SizedBox(height: 12,),

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
                          Align(
                            alignment: Alignment.centerLeft,
                            child: _hargaItem != null
                              ? Text(
                              'IDR. ' + _hargaItem,
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
                            )
                          ),

                          SizedBox(height: 8,),

                          Container(
                            child: TextFormField(
                              cursorColor: Colors.black,
                              style: GoogleFonts.openSans(fontSize: 12),
                              keyboardType: TextInputType.number,
                              controller: _jumlahItemController,
                              decoration: new InputDecoration(
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
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
                                      BorderSide(color: Color(0xFF1F3A93))),
                                  filled: false,
                                  contentPadding:
                                  EdgeInsets.only(left: 24.0, right: 24.0),
                                  hintStyle: GoogleFonts.openSans(
                                      fontSize: 12,
                                      color:
                                      Color(0xFF000000).withOpacity(0.15)),
                                  hintText: "Jumlah Item (lusin)",
                                  errorBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                      borderSide:
                                      BorderSide(color: Colors.red)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1)),
                                  errorStyle:
                                  GoogleFonts.openSans(fontSize: 10)),
                              obscureText: false,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Field is required";
                                }
                                return null;
                              },
                              onSaved: (value) {},
                            ),
                          ),

                          SizedBox(height: 24,),
                        ]
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(12),
                child: RaisedButton(
                  color: Color(0xFF1F3A93),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  textColor: Colors.white,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    alignment: Alignment.center,
                    child: Text(
                      "Simpan",
                      style: GoogleFonts.openSans(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          fontSize: 12
                      ),
                    ),
                  ),
                  onPressed: () {
                    saveOrder();
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  getItemDetail() async {
    DataSnapshot snapshot = await _reference.child(widget.itemKey).once();

    Map item = snapshot.value;

    _namaItem = item['nama'];
    _hargaItem = item['harga'];
    _urlItem = item['url'];
    setState(() {});

  }

  void saveOrder() {
    String namaPembeli = _namaPembeliController.text;
    String alamatPembeli = _alamatPembeliController.text;
    String jumlahItem = _jumlahItemController.text;

    Map<String,String> order = {
      'nama pembeli': namaPembeli,
      'alamat pembeli': alamatPembeli,
      'tanggal' : _date,
      'item key' : widget.itemKey,
      'nama item' : _namaItem,
      'harga item' : _hargaItem,
      'jumlah item' : jumlahItem,
    };

    _referenceOrder.push().set(order).then((value) {
      justReset();
      Navigator.pop(context);
    });
  }

  void justReset() {
    _jumlahItemController.clear();
    _alamatPembeliController.clear();
    _namaPembeliController.clear();
    _date = null;
    _namaItem = null;
    _hargaItem = null;
  }

}



