import 'package:dicoding_submission_flutter/AddPage/addPartnership.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class partnershipTab extends StatefulWidget {
  @override
  _partnershipTabState createState() => _partnershipTabState();
}

class _partnershipTabState extends State<partnershipTab> {

  DatabaseReference _referencePartner;
  Query _queryPartner;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _referencePartner = FirebaseDatabase.instance.reference().child('listPartnership');
    _queryPartner = FirebaseDatabase.instance.reference().child('listPartnership').orderByChild('nama');
  }

  Widget _buildListPartner({Map partner}){
    return GestureDetector(
      onTap: (){
        //_showDialogOrder(item['key']);
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
                  child: partner['url'] != null
                      ? Image.network(partner['url'], fit: BoxFit.fill,)
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
                          partner['nama'],
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
                          'IDR. ' + partner['harga'],
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => addPartnershipPage()));
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
                  "Partnership",
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
                        query: _queryPartner,
                        itemBuilder: (
                            BuildContext context,
                            DataSnapshot snapshot,
                            Animation<double> animation,
                            int index
                            ) {
                          Map partner = snapshot.value;
                          partner['key'] = snapshot.key;
                          return _buildListPartner(partner: partner);
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
}
