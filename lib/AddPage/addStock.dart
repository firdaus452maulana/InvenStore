import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class addStockPage extends StatefulWidget {
  @override
  _addStockPageState createState() => _addStockPageState();
}

class _addStockPageState extends State<addStockPage> {

  TextEditingController _namaItemController,
      _hargaItemController;
  DatabaseReference _reference;
  File _imageItem;
  String _urlItemImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _namaItemController = TextEditingController();
    _hargaItemController = TextEditingController();
    _reference = FirebaseDatabase.instance.reference().child('listItem');
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
                  "Add Stock",
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

                          // NAMA ITEM
                          Container(
                            child: TextFormField(
                              cursorColor: Colors.black,
                              style: GoogleFonts.openSans(fontSize: 12),
                              keyboardType: TextInputType.text,
                              controller: _namaItemController,
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
                                      BorderSide(color: Color(0xFF031F4B))),
                                  filled: false,
                                  contentPadding:
                                  EdgeInsets.only(left: 24.0, right: 24.0),
                                  hintStyle: GoogleFonts.openSans(
                                      fontSize: 12,
                                      color:
                                      Color(0xFF000000).withOpacity(0.15)),
                                  hintText: "Nama Item",
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

                          // NAMA ITEM
                          Container(
                            child: TextFormField(
                              cursorColor: Colors.black,
                              style: GoogleFonts.openSans(fontSize: 12),
                              keyboardType: TextInputType.text,
                              controller: _hargaItemController,
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
                                      BorderSide(color: Color(0xFF031F4B))),
                                  filled: false,
                                  contentPadding:
                                  EdgeInsets.only(left: 24.0, right: 24.0),
                                  hintStyle: GoogleFonts.openSans(
                                      fontSize: 12,
                                      color:
                                      Color(0xFF000000).withOpacity(0.15)),
                                  hintText: "Harga Item",
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
                                      postImage(_imageItem).then((downloadUrl) {
                                        _urlItemImage = downloadUrl;
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
    FirebaseStorage.instance.ref().child('fotoItem/$fileName');
    await reference.putFile(imageFile);
    // UploadTask uploadTask = reference.putData((await imageFile.getByteData()).buffer.asUint8List());
    return await reference.getDownloadURL();
  }

  void saveItem() {

    String namaItem = _namaItemController.text;
    String hargaItem = _hargaItemController.text;
    String urlItem = _urlItemImage;
    Map<String,String> item = {
      'nama' : namaItem,
      'harga' : hargaItem,
      'url' : urlItem,
    };

    _reference.push().set(item).then((value) {
      justReset();
      Navigator.pop(context);
    });
  }

  justReset() {
    _namaItemController.clear();
    _hargaItemController.clear();
    _urlItemImage = null;
    _imageItem = null;
  }
}
