import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

/*Future<void> scanBarcodeNormal() async {
  String barcodeScanRes;
  try {
    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", true, ScanMode.BARCODE);
    print(barcodeScanRes);
  } on PlatformException {
    barcodeScanRes = 'Failed to get platform version.';
  }
}*/

class OrderScreen extends StatefulWidget {
  @override
  Order_state createState() => Order_state();
}

// ignore: missing_return
Future<dynamic> scanBarcodeNormal(e, f) async {
  final i = await FlutterBarcodeScanner.scanBarcode(
      "#000000", "Cancel", true, ScanMode.BARCODE);
  print("YO SOY LO LEIDOOOOOOOOOOOOOOOOO!!!!!!!!!!!!!!!:   " + i);
  return i;
}

Future<int> scanBarcodeNormal2(e, f) async {
  final d = await scanBarcodeNormal(e, f);
  if (d == "-1") {
    return 0;
  } else {
    if (f.containsKey(d)) {
      e.add(f[d]);
      return 0;
    } else {
      return 1;
    }
  }
}

Map<String, int> barcodemap = {
  "12345678": 0,
  "08329742": 1,
  "08329743": 2,
  "08329744": 3,
  "08329745": 4,
  "08329746": 5,
  "08329747": 6,
  "08329748": 7,
  "08329749": 8,
  "08329750": 9,
  "08329751": 10,
  "08329752": 11,
  "08329753": 12,
  "08329754": 13,
  "08329755": 14,
  "08329756": 15,
  "08329757": 16,
  "08329758": 17,
  "08329759": 18,
  "08329760": 19,
  "08329761": 20,
  "08329762": 21,
  "08329774": 22,
  "08329764": 23,
  "08329765": 24,
  "08329766": 25,
  "08329767": 26,
  "08329768": 27,
  "08329769": 28,
  "08329770": 29,
  "08329771": 30,
  "08329772": 31,
  "08329773": 32
};

List<int> indices = [];

class Order_state extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    var indmap = indices.asMap();
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: ListView(children: <Widget>[
            Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(children: <Widget>[
                      Text('Want to see',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 40,
                              fontWeight: FontWeight.bold)),
                      Text("Your order?",
                          style: TextStyle(
                              fontSize: 30,
                              color: Color(0xFF004D40),
                              fontWeight: FontWeight.bold))
                    ]),
                    Image.asset(
                      'assets/imgs/order2.png',
                      height: 120,
                      width: 120,
                    )
                  ]),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('products')
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List<DocumentSnapshot> docs = snapshot.data.docs;
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "TOTAL: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        Text(
                          NumberFormat.simpleCurrency(
                            locale: "en_US",
                            decimalDigits: 0,
                          )
                              .format(indmap
                                  .map((key, value) => MapEntry(
                                      key, docs[indices[key]].data()["price"]))
                                  .values
                                  .toList()
                                  .fold(0, (p, c) => p + c))
                              .toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        )
                      ],
                    ),
                  );
                }),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('products')
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List<DocumentSnapshot> docs = snapshot.data.docs;
                  return Expanded(
                    child: SizedBox(
                      height: 700,
                      child: ListView(
                          children: indmap
                              .map((key, value) => MapEntry(
                                    key,
                                    Dismissible(
                                        key: UniqueKey(),
                                        background: Container(
                                          alignment:
                                              AlignmentDirectional.centerEnd,
                                          color: Colors.red,
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 10),
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        onDismissed: (direction) {
                                          setState(() {
                                            print("eliminando" +
                                                value.toString());
                                            print(indices);
                                            indices.removeAt(key);
                                          });
                                        },
                                        child: casilla(context, docs, value)),
                                  ))
                              .values
                              .toList()),
                    ),
                  );
                }),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final x = await scanBarcodeNormal2(indices, barcodemap);
          if (x == 0) {
            setState(() {});
          } else {
            no_encontrado(context);
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}

void no_encontrado(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          content: Container(
            height: 400,
            child: Column(
              children: [
                Image.asset(
                  "assets/imgs/sad.jpg",
                  height: 180,
                  width: 200,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: Text(
                    "Sorry, we can´t find this product in our database",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                    width: 200,
                    height: 60,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      elevation: 30,
                      minWidth: 200,
                      color: Theme.of(context).primaryColor,
                      height: 60,
                      child: Text(
                        "Continue",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ))
              ],
            ),
          ),
        );
      });
}

Widget casilla(BuildContext context, docs, ind) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Row(children: <Widget>[
        ClipRRect(
          child: Image.asset(
            docs[ind].data()['url'],
            width: 100,
            fit: BoxFit.contain,
            height: 150,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        Container(
            padding: EdgeInsets.only(left: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FittedBox(
                  child: Text(
                    docs[ind].data()["name"],
                    style: TextStyle(
                        fontFamily: "Font2",
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                            docs[ind].data()['net_wt'].toString() + 'gr',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                            NumberFormat.simpleCurrency(
                                    locale: "eng_US", decimalDigits: 0)
                                .format(docs[ind].data()['price'])
                                .toString(),
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ],
            ))
      ]),
    ),
  );
}
/*Center(
child: const Text('Press the button below to modify the order!')
),
floatingActionButton: FloatingActionButton(
onPressed: ()  => scanBarcodeNormal(),
child: Icon(Icons.add),
backgroundColor: Theme.of(context).primaryColor,
),*/

/*class DataController extends GetxController {
  Future getData(String colecction) async{
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot =
        await firebaseFirestore.collection(colecction).get();
    return snapshot.docs;
  }
  Future queryData(String queryString) async{
    return FirebaseFirestore.instance.collection('featured').where(
      'name', isGreaterThanOrEqualTo: queryString
    ).get();
  }
}*/
