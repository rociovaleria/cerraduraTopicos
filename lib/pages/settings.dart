import 'package:cerradura/pages/registroPin.dart';
import 'package:flutter/material.dart';
import 'package:app_settings/app_settings.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      title: Text('Seguridad,Pin',style: TextStyle(color: Colors.white,)),
                      subtitle: Text(
                          'Cambia las configuraciones de seguridad, ingresando un nuevo pin',style: TextStyle(color:Color.fromRGBO(201, 156, 239, 100) ),),
                      contentPadding: EdgeInsets.all(20.0),
                      leading: Icon(Icons.lock_open,color:Color.fromRGBO(201, 156, 239, 100) ,),
                      onTap: (){
                          final route = MaterialPageRoute(builder: (context) {
                    return RegistroPin();
                     });

                 Navigator.push(context, route);
                      },
                    ),
                    ListTile(
                      title: Text('Huellas Dactilares',style: TextStyle(color: Colors.white,)),
                      subtitle: Text('Configure el uso de huellas dactilares',style: TextStyle(color: Color.fromRGBO(201, 156, 239, 100)),),
                      contentPadding: EdgeInsets.all(20.0),
                      leading: Icon(Icons.fingerprint,color: Color.fromRGBO(201, 156, 239, 100),),
                      onTap: () {
                        AppSettings.openSecuritySettings();
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
