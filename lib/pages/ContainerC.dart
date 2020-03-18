import 'package:cerradura/application/finger_print_validator_facade.dart';
import 'package:cerradura/pages/servicioPrincipal.dart';
import 'package:cerradura/pages/settings.dart';
import 'package:cerradura/providers/Bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContainerC extends StatefulWidget {
  @override
  _ContainerCState createState() => _ContainerCState();
}

class _ContainerCState extends State<ContainerC> {
  ContainerC createState() => new ContainerC();

  @override
  Widget build(BuildContext context) {
    // debugCheckIntrinsicSizes = false;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GestureDetector(
            child: Icon(
              Icons.arrow_back,
            ),
            onTap: () {
              // Navigator.push(context, Route(Home);
            },
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 5.0,
                ),
                _titulos(),
                _botones(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _titulos() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Text('Services Domotic',
                style: TextStyle(
                    color: Color.fromRGBO(201, 156, 239, 100),
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _botones() {
    return Table(
      children: [
        TableRow(children: [
          _crearBoton(Color.fromRGBO(201, 156, 239, 100),
              Icons.bluetooth_connected, 'Bluetooth'),
          _crearBoton(
              Color.fromRGBO(201, 156, 239, 100), Icons.settings, 'Configuraciones'),
        ]),
        TableRow(children: [
          _crearBoton(
            Color.fromRGBO(201, 156, 239, 100),
            Icons.lock_open,
            'Open Door',
          ),
          _crearBoton(Color.fromRGBO(201, 156, 239, 100), Icons.close, 'Salir'),
        ]),
      ],
    );
  }

  Widget _crearBoton(Color color, IconData icono, String texto) {
    return Container(
      height: 150.0,
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          // color: Colors.lime[600],
          color: Colors.white10,
          borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(
            height: 5.0,
          ),
          GestureDetector(
              child: CircleAvatar(
                backgroundColor: color,
                radius: 35.0,
                child: Icon(
                  icono,
                  color: Colors.white,
                  size: 30.0,
                ),
              ),
              onTap: () {
                if (texto == 'Bluetooth') {
                  final route = MaterialPageRoute(builder: (context) {
                    return MainPage();
                    //FormularioTrabajador();
                  });
                  Navigator.push(context, route);
               
                }
                 if (texto == 'Configuraciones') {
                  final route = MaterialPageRoute(builder: (context) {
                    return Settings();
                  });
                  Navigator.push(context, route);
           
                }
                 if (texto == 'Open Door') {
                   final route = MaterialPageRoute(builder: (context) {
                    return ServicioPrincipal();
                     });

                 Navigator.push(context, route);

                  
                }
                 if (texto == 'Salir') {
                
                  SystemNavigator.pop();
                  
                 
                }
              }),
          Text(
            texto,
            style: TextStyle(color: color),
          ),
          SizedBox(
            height: 5.0,
          ),
        ],
      ),
    );
  }
  void procesarRespuestaValidador(bool respuesta) {
      String resp = "";
      if (respuesta) {
        resp = "";
      } else {
        resp = "Intente de nuevo";
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Resultado de la validacion"),
            content: new Text(resp),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Cerrar"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    void verificarHuella() {
      Future<bool> verificar = FingerPrintValidatorFacade.validate();
      verificar
          .then((value) => procesarRespuestaValidador(value))
          .catchError((error) => procesarRespuestaValidador(false));
    }





}
