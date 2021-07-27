import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class addPartnershipPage extends StatefulWidget {
  @override
  _addPartnershipPageState createState() => _addPartnershipPageState();
}

class _addPartnershipPageState extends State<addPartnershipPage> {

  var scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _namapartnerController,
      _alamatpartnerController,
      _teleponpartnerController;
  DatabaseReference _reference;
  File _imageItem;
  String _urlItemImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _namapartnerController = TextEditingController();
    _alamatpartnerController = TextEditingController();
    _teleponpartnerController = TextEditingController();
    _reference = FirebaseDatabase.instance.reference().child('listPartner');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
                  "Add Partnership",
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

                          // NAMA PARTNER
                          Container(
                            child: TextFormField(
                              cursorColor: Colors.black,
                              style: GoogleFonts.openSans(fontSize: 12),
                              keyboardType: TextInputType.text,
                              controller: _namapartnerController,
                              decoration: new InputDecoration(
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                      borderSide: BorderSide(
                                          color: Color(0xFF000000)
                                              .withOpacity(0.15))),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                      borderSide:
                                      BorderSide(color: Color(0xFF1F3A93))),
                                  filled: false,
                                  contentPadding:
                                  EdgeInsets.only(left: 24.0, right: 24.0),
                                  hintStyle: GoogleFonts.openSans(
                                      fontSize: 12,
                                      color:
                                      Color(0xFF000000).withOpacity(0.15)),
                                  hintText: "Nama Partner",
                                  errorBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                      borderSide:
                                      BorderSide(color: Colors.red)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
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

                          // TELEPON PARTNER
                          Container(
                            child: TextFormField(
                              cursorColor: Colors.black,
                              style: GoogleFonts.openSans(fontSize: 12),
                              keyboardType: TextInputType.number,
                              controller: _teleponpartnerController,
                              decoration: new InputDecoration(
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                      borderSide: BorderSide(
                                          color: Color(0xFF000000)
                                              .withOpacity(0.15))),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                      borderSide:
                                      BorderSide(color: Color(0xFF1F3A93))),
                                  filled: false,
                                  contentPadding:
                                  EdgeInsets.only(left: 24.0, right: 24.0),
                                  hintStyle: GoogleFonts.openSans(
                                      fontSize: 12,
                                      color:
                                      Color(0xFF000000).withOpacity(0.15)),
                                  hintText: "Nomor Telepon",
                                  errorBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                      borderSide:
                                      BorderSide(color: Colors.red)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
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

                          // ALAMAT PARTNER
                          Container(
                            child: TextFormField(
                              cursorColor: Colors.black,
                              style: GoogleFonts.openSans(fontSize: 12),
                              maxLines: 10,
                              controller: _alamatpartnerController,
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
                                  hintText: "Alamat",
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

                          Container(
                              width: 250,
                              height: 250,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                child: _imageItem != null
                                    ? Image.file(_imageItem)
                                    : FlatButton(
                                  child: Icon(
                                    Icons.add_a_photo,
                                    size: 50,
                                  ),
                                  onPressed: () async {
                                    await ImagePicker.pickImage(
                                        source: ImageSource.gallery)
                                        .then((img) {
                                      _imageItem = img;
                                    });
                                    SnackBar snackbar = SnackBar(
                                        content:
                                        Text('Mohon Tunggu'));
                                    scaffoldKey.currentState
                                        .showSnackBar(snackbar);
                                    postImage(_imageItem).then((downloadUrl) {
                                      _urlItemImage = downloadUrl;
                                      SnackBar snackbar = SnackBar(
                                          content:
                                          Text('Uploaded Successfully'));
                                      scaffoldKey.currentState
                                          .showSnackBar(snackbar);
                                    });
                                    setState(() {});
                                  },
                                ),
                              )
                          ),
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
                    saveItem();
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<String> postImage(File imageFile) async {
    String fileName = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();
    Reference reference =
    FirebaseStorage.instance.ref().child('fotoPartner/$fileName');
    await reference.putFile(imageFile);
    // UploadTask uploadTask = reference.putData((await imageFile.getByteData()).buffer.asUint8List());
    return await reference.getDownloadURL();
  }

  void saveItem() {

    String namaPartner = _namapartnerController.text;
    String teleponPartner = _teleponpartnerController.text;
    String alamatPartner = _alamatpartnerController.text;
    String urlItem = _urlItemImage;
    Map<String,String> partner = {
      'nama' : namaPartner,
      'telepon' : teleponPartner,
      'alamat' : alamatPartner,
      'url' : urlItem,
    };

    _reference.push().set(partner).then((value) {
      justReset();
      Navigator.pop(context);
    });
  }

  justReset() {
    _namapartnerController.clear();
    _teleponpartnerController.clear();
    _alamatpartnerController.clear();
    _urlItemImage = null;
    _imageItem = null;
  }
}
