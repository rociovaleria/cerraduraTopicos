import 'package:cerradura/providers/Bluetooth.dart';
import 'package:cerradura/src/preferencias/preferencias_usuarios.dart';
import 'package:flutter/material.dart';
class ValidarPin extends StatelessWidget {
  final pinController = TextEditingController();
   final prefe = new PreferenciasUsuario();
MainPage main= new MainPage();
 @override
 Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              children: <Widget>[
                Text('Ingrese el Pin',style: TextStyle(color: Color.fromRGBO(201, 156, 239, 100),fontSize: 20.0),),
                SizedBox(height: 20.0,),
                  TextField(
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.w300),
                    controller: pinController,
                    obscureText: true,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(prefixIcon: Icon(Icons.lock_open,color: Colors.white,),fillColor: Colors.white),
                      keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
            //  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              shape: StadiumBorder(),
              color: Colors.black,
              textColor: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                child: Text(
                  "Ir",
                  style: TextStyle(fontSize: 22.0,color: Color.fromRGBO(201, 156, 239, 100)),
                ),
              ),
              onPressed: () {
               _verificar(context);
              })
              ],
            ),
          ),
        ),
      );
    }

    _error( BuildContext context){
   showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('El pin no coincide, vuelva a intentarlo'),
          actions: <Widget>[
            FlatButton(
              child: Text('ok'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      }
      );
    }
  void _verificar(BuildContext context){
    print(prefe.password);
    print(pinController.text);
    if(pinController.text==prefe.password){
      print('verdadero pines iguales');
       MainPage().enviar();

      ///mandar señal al arduino
    }else{
      _error(context);
    }
  }
  
}