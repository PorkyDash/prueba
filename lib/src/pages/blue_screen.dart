import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_app/src/pages/blue_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  List<BluetoothDevice> devices = List<BluetoothDevice>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _getBTState();
    _stateChangeListener();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state.index == 0) {
      //resume
      if (_bluetoothState.isEnabled) {
        _listBondedDevices();
      }
    }
  }

  _getBTState() {
    FlutterBluetoothSerial.instance.state.then((state) {
      _bluetoothState = state;
      if (_bluetoothState.isEnabled) {
        _listBondedDevices();
      }
      setState(() {});
    });
  }

  _stateChangeListener() {
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      _bluetoothState = state;
      if (_bluetoothState.isEnabled) {
        _listBondedDevices();
      } else {
        devices.clear();
      }
      print("State isEnabled: ${state.isEnabled}");
      setState(() {});
    });
  }

  _listBondedDevices() {
    FlutterBluetoothSerial.instance
        .getBondedDevices()
        .then((List<BluetoothDevice> bondedDevices) {
      devices = bondedDevices;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BLUETOOTH",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            SwitchListTile(
              title: Text(
                'Enable Bluetooth',
              ),
              value: _bluetoothState.isEnabled,
              onChanged: (bool value) {
                future() async {
                  if (value) {
                    await FlutterBluetoothSerial.instance.requestEnable();
                  } else {
                    await FlutterBluetoothSerial.instance.requestDisable();
                  }
                  future().then((_) {
                    setState(() {});
                  });
                }
              },
            ),
            ListTile(
              title: Text("Bluetooth STATUS"),
              subtitle: Text(_bluetoothState.toString()),
              trailing: RaisedButton(
                child: Text("Settings"),
                onPressed: () {
                  FlutterBluetoothSerial.instance.openSettings();
                },
              ),
            ),
            Expanded(
              child: ListView(
                children: devices
                    .map((_device) => BluetoothDeviceListEntry(
                          device: _device,
                          enabled: true,
                          onTap: () {
                            print("Item");
                            //_startCameraConnect(context, _device);
                          },
                        ))
                    .toList(),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'main');
                },
                splashColor: Colors.white,
                highlightColor: Colors.white,
                child: (Image.asset(
                  'assets/imgs/img2.jpg',
                  height: 200,
                )),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              alignment: Alignment.bottomCenter,
              child: Text(
                "Please pair your device with the robot and tap me to continue",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
