import 'package:cerradura/src/preferencias/preferencias_usuarios.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


String validationPassword;
 final pref = new PreferenciasUsuario();
class RegistroPin extends StatefulWidget {
  @override
  _RegistroPinState createState() => _RegistroPinState();
}
final formkey = GlobalKey<FormState>();
class _RegistroPinState extends State<RegistroPin> {
  bool recordar = false;
 
  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final loginButton = new RaisedButton(
        child: Text('Guardar'),
        color: Color.fromRGBO(201, 156, 239, 100),
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(20.0)),
        onPressed: () {
         _submit(context);
        });
//  onPressed: AppSettings.openLocationSettings(),
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 80),
        color: Colors.black,
        child: SingleChildScrollView(
          child: Form(
             key: formkey,
            child: Container(
              color: Colors.white10,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 35.0,
                    child: Icon(
                      Icons.security,
                      color: Color.fromRGBO(201, 156, 239, 100),
                      size: 50.0,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  pin1Field(),
                  SizedBox(height: 20),
                  Text('Vuelva a escribir el pin',
                      style: TextStyle(
                          color: Color.fromRGBO(201, 156, 239, 100),
                          fontSize: 15.0)),
                  SizedBox(height: 20),
                  pin2Field(),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: loginButton,
                  ),
                  SizedBox(height: 15.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget pin1Field() {
    return TextFormField(
      //initialValue: loginmodel.email,
      obscureText: true,
      decoration: new InputDecoration(
        labelText: "Pin",
        labelStyle: TextStyle(color: Colors.white70),
        border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(20.0),

            borderSide: BorderSide(color: Colors.white10)),
      ),
      keyboardType: TextInputType.number,
      onSaved: (value) => pref.password = value,

      validator: (value) {
        return (value.length < 3)
            ? 'seguridad baja, ingrese un pin nuevo'
            : null;
      },
    );

  }

  Widget pin2Field() {
    return TextFormField(
      //  initialValue: loginmodel.password,
      obscureText: true,
      decoration: new InputDecoration(
        labelText: "Pin",
        labelStyle: TextStyle(color: Colors.white70),
        border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Colors.white10)),
      ),
      keyboardType: TextInputType.number,
      onSaved: (value) => validationPassword = value,
      validator: (value) {
        return (value.length < 3) ? 'ingrese correcto': null;
      },
    );
  }

  bool _validarPassword() {
    String pin1;
    print('***********************************pasw preferencia guardado');
    print(pref.password);
    pin1 = pref.password;
    print('pass2**********');
    print(validationPassword);
    if(pin1==validationPassword){

      return true;
    }else{
      
      return false;
    }
  }
  void _submit(BuildContext context) async {
     if (!formkey.currentState.validate()) return;
    formkey.currentState.save();
  bool ban;
  ban =_validarPassword();
  print(ban);
//Map info = await loginProvider.login(loginmodel.email, loginmodel.password);
  if (ban==true) {
    _showDialogSuccess(context);
   
  } else {
    _showDialogError(context);
  }
}
}

void _showDialogError(BuildContext context) {
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
      });
 
}

void _showDialogSuccess(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Success !!'),
          actions: <Widget>[
            FlatButton(
              child: Text('ok'),
              onPressed: () =>  Navigator.pushReplacementNamed(context, 'home')
            )
          ],
        );
      });
 
}
