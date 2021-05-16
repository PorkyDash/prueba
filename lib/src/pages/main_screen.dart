import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            _customAppBar(context),
            _textsheader(context),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                  height: 150,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    elevation: 30,
                    color: Theme.of(context).primaryColor,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text("Move",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold)),
                          Image.asset(
                            'assets/imgs/move.png',
                            height: 120,
                            width: 120,
                          ),
                        ]),
                    onPressed: () {
                      Navigator.pushNamed(context, 'move');
                    },
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                  height: 150,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    elevation: 30,
                    color: Theme.of(context).primaryColor,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text("Order",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold)),
                          Image.asset(
                            'assets/imgs/order.png',
                            height: 120,
                            width: 120,
                          ),
                        ]),
                    onPressed: () {
                      Navigator.pushNamed(context, 'order');
                    },
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                  height: 150,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    elevation: 30,
                    color: Theme.of(context).primaryColor,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text("Status",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold)),
                          Image.asset(
                            'assets/imgs/batt.png',
                            height: 120,
                            width: 120,
                          ),
                        ]),
                    onPressed: () {},
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _customAppBar(context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          iconSize: 15,
          onPressed: () {
            Navigator.pushNamed(context, 'home');
          },
          icon: SvgPicture.asset(
            'assets/icons/home.svg',
            color: Colors.lightBlue,
          ),
        ),
        Row(
          children: <Widget>[
            IconButton(
              iconSize: 15,
              onPressed: () {
                Navigator.pushNamed(context, 'blue');
              },
              icon: SvgPicture.asset(
                'assets/icons/settings.svg',
                color: Colors.lightBlue,
              ),
            ),
          ],
        )
      ],
    ),
  );
}

Widget _textsheader(context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Hey, ', style: Theme.of(context).textTheme.bodyText1),
        Text("Ready for", style: Theme.of(context).textTheme.headline1),
        Text('Shopping?', style: Theme.of(context).textTheme.headline2)
      ],
    ),
  );
}
