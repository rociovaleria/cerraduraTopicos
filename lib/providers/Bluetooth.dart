import 'dart:async';
import 'package:cerradura/src/preferencias/preferencias_usuarios.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'dart:convert';
import 'Dispositivo.dart';

final pref = new PreferenciasUsuario();

class MainPage extends StatefulWidget {
  void enviar() async {
    _MainPage nueva = new _MainPage();
    nueva.validar();
  }
  @override
  _MainPage createState() => new _MainPage();
}

class _MainPage extends State<MainPage> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  String _direccion = "...";
  String _nombre = "...";
  String controlador = 'holamsj';

  Timer _tiempoListar;
  int _discoverableTimeoutSecondsLeft = 0;
  BluetoothDevice selectedDevice;

  BluetoothConnection connection;
  bool _autoAcceptPairingRequests = false;

  @override
  void initState() {
    super.initState();

    // Get current state
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    Future.doWhile(() async {
      // Wait if adapter not enabled
      if (await FlutterBluetoothSerial.instance.isEnabled) {
        return false;
      }
      await Future.delayed(Duration(milliseconds: 0xDD));
      return true;
    }).then((_) {
      FlutterBluetoothSerial.instance.address.then((address) {
        setState(() {
          _direccion = address;
        });
      });
    });

    FlutterBluetoothSerial.instance.name.then((name) {
      setState(() {
        _nombre = name;
      });
    });

    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;
        _tiempoListar = null;
        _discoverableTimeoutSecondsLeft = 0;
      });
    });
  }

  @override
  void dispose() {
    FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
    _tiempoListar?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(201, 156, 239, 100),
        title: const Text('Bluetooth',
            style: TextStyle(
              color: Colors.black,
            )),
      ),
      body: Container(
        color: Colors.black,
        child: ListView(
          children: <Widget>[
            Divider(),
            SwitchListTile(
              title: const Text('Activar Bluetooth',
                  style: TextStyle(color: Color.fromRGBO(201, 156, 239, 100))),
              value: _bluetoothState.isEnabled,
              onChanged: (bool value) {
                future() async {
                  if (value)
                    await FlutterBluetoothSerial.instance.requestEnable();
                  else
                    await FlutterBluetoothSerial.instance.requestDisable();
                }

                future().then((_) {
                  setState(() {});
                });
              },
            ),
            ListTile(
              title: const Text('Nombre Adaptador',
                  style: TextStyle(color: Color.fromRGBO(201, 156, 239, 100))),
              subtitle: Text(_nombre,
                  style: TextStyle(color: Color.fromRGBO(201, 156, 239, 100))),
              onLongPress: null,
            ),
            Divider(),
            ListTile(
              title: RaisedButton(
                  child: const Text('Enviar'),
                  onPressed: () async {
                    print('enviando mensaje 0');

                    _enviarMensaje();
                    // connection.output.add(utf8.encode("1"));
                    //await connection.output.allSent;
                  }),
            ),
            //tal v es no use este boton
            ListTile(
              title: RaisedButton(
                  child: const Text('Explorar dispositivos'),
                  onPressed: () async {
                    final BluetoothDevice selectedDevice =
                        await Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                      return DiscoveryPage();
                    }));

                    if (selectedDevice != null) {
                      print('Discovery -> selected ' + selectedDevice.address);
                      print('*********************************dispositivo');
                      print(selectedDevice.address);
                      print('esta es la preferncia');
                      pref.direccion = selectedDevice.address.toString();
                    } else {
                      print('Discovery -> no device selected');
                    }
                  }),
            ),
            ListTile(
              title: RaisedButton(
                child: ((selectedDevice != null)
                    ? const Text('Desconectar')
                    : const Text('Conectar')),
                onPressed: () async {
                  if (selectedDevice != null) {
                    connection.cancel();

                    setState(() {
                      /* Update for `_collectingTask.inProgress` */
                    });
                  } else {
                    BluetoothDevice _selectedDevice =
                        await Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                      return SelectBondedDevicePage(checkAvailability: false);
                    }));
                    setState(() {
                      selectedDevice = _selectedDevice;
                      print('****************************dispositivo seleccionado');
                      print(selectedDevice);
                    });
                    // BluetoothConnection connection = await BluetoothConnection.toAddress(pref.direccion);

                    BluetoothConnection.toAddress(selectedDevice.address)
                        .then((_connection) {
                      connection = _connection;
                      print('conectado con el dispositivo');
                      setState(() {
                        
                        connection = _connection;
                        print('la conexion con el sispotivo');
                        pref.estadoConexion=true;
                      });
                    });

                    print(connection);
                    print(connection.isConnected);

                    pref.direccion = selectedDevice.address;
                    print('ESTA ES LA PREF  *******' + pref.direccion);

                    print(selectedDevice.address.toString());
                    print('****************pref name');

                    pref.name = selectedDevice.name;
                    print('PREF NAME  ' + pref.name);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void justWait({@required int numberOfSeconds}) async {
    await Future.delayed(Duration(seconds: numberOfSeconds));
  }

  void _enviarMensaje() async {
    try {
    
      connection.output.add(utf8.encode('1'));
      await connection.output.allSent;
    } catch (e) {
      print("No se pudo mandar el mensaje");
    }
  }

  void validar() async {
    
    //if(pref.estadoConexion){
      BluetoothConnection.toAddress(pref.direccion).then((_connection) {
          connection = _connection;
        print('conectado con el dispositivo');   
      }
      );
      
      _enviarMensaje();
      print(" enviando mensaje");
     
    //}
    //else{
     
    //}
    
  }
}

class SelectBondedDevicePage extends StatefulWidget {
  final bool checkAvailability;

  const SelectBondedDevicePage({this.checkAvailability = true});

  @override
  _SelectBondedDevicePage createState() => new _SelectBondedDevicePage();
}

enum _DeviceAvailability {
  no,
  maybe,
  yes,
}

class _DeviceWithAvailability extends BluetoothDevice {
  BluetoothDevice device;
  _DeviceAvailability availability;
  int rssi;

  _DeviceWithAvailability(this.device, this.availability, [this.rssi]);
}

class _SelectBondedDevicePage extends State<SelectBondedDevicePage> {
  List<_DeviceWithAvailability> devices = List<_DeviceWithAvailability>();

  // Availability
  StreamSubscription<BluetoothDiscoveryResult> _discoveryStreamSubscription;
  bool _isDiscovering;

  _SelectBondedDevicePage();

  @override
  void initState() {
    super.initState();

    _isDiscovering = widget.checkAvailability;

    if (_isDiscovering) {
      _startDiscovery();
    }

    FlutterBluetoothSerial.instance
        .getBondedDevices()
        .then((List<BluetoothDevice> bondedDevices) {
      setState(() {
        devices = bondedDevices
            .map((device) => _DeviceWithAvailability(
                device,
                widget.checkAvailability
                    ? _DeviceAvailability.maybe
                    : _DeviceAvailability.yes))
            .toList();
      });
    });
  }

  void _restartDiscovery() {
    setState(() {
      _isDiscovering = true;
    });

    _startDiscovery();
  }

  void _startDiscovery() {
    _discoveryStreamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      setState(() {
        Iterator i = devices.iterator;
        while (i.moveNext()) {
          var _device = i.current;
          if (_device.device == r.device) {
            _device.availability = _DeviceAvailability.yes;
            _device.rssi = r.rssi;
          }
        }
      });
    });

    _discoveryStreamSubscription.onDone(() {
      setState(() {
        _isDiscovering = false;
      });
    });
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and cancel discovery
    _discoveryStreamSubscription?.cancel();

    super.dispose();
  }

//Conectar
  @override
  Widget build(BuildContext context) {
    List<BluetoothDeviceListEntry> list = devices
        .map((_device) => BluetoothDeviceListEntry(
              device: _device.device,
              rssi: _device.rssi,
              enabled: _device.availability == _DeviceAvailability.yes,
              onTap: () {
                Navigator.of(context).pop(_device.device);
                //aqui podria guardar la mac del dispositivo concrtadp
              },
            ))
        .toList();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(201, 156, 239, 100),
          title: Text(
            'Seleccionar dispositivo',
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            (_isDiscovering
                ? FittedBox(
                    child: Container(
                        color: Colors.black,
                        margin: new EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white))))
                : IconButton(
                    icon: Icon(
                      Icons.replay,
                      color: Color.fromRGBO(201, 156, 239, 100),
                    ),
                    onPressed: _restartDiscovery))
          ],
        ),
        body: Container(color: Colors.black, child: ListView(children: list)));
  }
}
