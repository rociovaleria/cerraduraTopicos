import 'package:cerradura/pages/ContainerC.dart';
import 'package:cerradura/pages/home.dart';
import 'package:cerradura/pages/registroPin.dart';
import 'package:cerradura/pages/servicioPrincipal.dart';
import 'package:cerradura/pages/settings.dart';
import 'package:cerradura/pages/validatiorPin.dart';
import 'package:cerradura/providers/Bluetooth.dart';
import 'package:cerradura/src/preferencias/preferencias_usuarios.dart';
import 'package:flutter/material.dart';

void main() async{
  final prefs= new PreferenciasUsuario();
  await prefs. initPrefs();
  runApp(MyApp());}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final pref=new PreferenciasUsuario();
    print('este es el pass');
    print(pref.password);
    print('esta es la direccion mac de pref');
    print(pref.direccion);
  
      return MaterialApp(
         debugShowCheckedModeBanner: false,
         initialRoute: 'home',
          routes:{
            'home': (BuildContext context)=>Home(), 
            'principal':(BuildContext context )=>ContainerC(),
            'servicio':(BuildContext context)=>ServicioPrincipal(),
            'setting':(BuildContext context)=>Settings(),
            'pin':(BuildContext context)=>RegistroPin(),
            'validarPin':(BuildContext context)=>ValidarPin(),
            'bluetooth':(BuildContext context)=>MainPage()
           /* 'configuracion': (BuildContext context)=>FormularioTrabajador(), 
            'principal': (BuildContext context)=>Principal(), */
            

            
          },
      );
    
    
  }


}

