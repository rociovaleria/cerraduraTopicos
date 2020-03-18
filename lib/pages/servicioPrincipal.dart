import 'dart:async';
import 'package:cerradura/application/finger_print_validator_facade.dart';
import 'package:cerradura/pages/validatiorPin.dart';
import 'package:cerradura/providers/Bluetooth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ServicioPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void procesarRespuestaValidador(bool respuesta) {
      String resp = "";
      if (respuesta) {
        resp = "Se ha logrado autenticar con exito";
       MainPage().enviar();
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
    

    Widget _bo1() {
      return Container(
        height: 150.0,
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.white10, borderRadius: BorderRadius.circular(20.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(
              height: 5.0,
            ),
            GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 35.0,
                  child: Icon(
                    Icons.fingerprint,
                    size: 40.0,
                    color: Color.fromRGBO(201, 156, 239, 100),
                  ),
                ),
                onTap: () {
                  verificarHuella();
                }),
            SizedBox(
              height: 5.0,
            ),
            Text('Ingresar con Huella',
                style: TextStyle(color: Colors.white, fontSize: 10.0))
          ],
        ),
      );
    }

    Widget _pin() {
      return Container(
        height: 150.0,
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(
              height: 5.0,
            ),
            GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 35.0,
                  child: Icon(
                    Icons.lock_outline,
                    size: 40.0,
                    color: Color.fromRGBO(201, 156, 239, 100),
                  ),
                ),
                onTap: (){
                  
                   final route = MaterialPageRoute(builder: (context) {
                    return ValidarPin();
                     });

                 Navigator.push(context, route);
                  }
                ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              'Ingresar con Pin',
              style: TextStyle(color: Colors.white, fontSize: 10.0),
            )
          ],
        ),
      );
    }
   
   

    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column( 
        
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Padding(padding: const EdgeInsets.all(30.0)),
            Text('Open the Door',
                style: TextStyle(
                  color: Color.fromRGBO(201, 156, 239, 100),
                  fontSize: 30.0,
                )),
            SizedBox(
              height: 40.0,
              width: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70.0),
              child: Row(
                children: <Widget>[
                  _bo1(),
                  _pin(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
