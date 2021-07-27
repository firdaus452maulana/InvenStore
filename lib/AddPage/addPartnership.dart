import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class addPartnershipPage extends StatefulWidget {
  @override
  _addPartnershipPageState createState() => _addPartnershipPageState();
}

class _addPartnershipPageState extends State<addPartnershipPage> {

  var scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _namaItemController,
      _hargaItemController;
  DatabaseReference _reference, _ref;
  File _imageItem;
  String _urlItemImage;
  int _jumlahItem;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
