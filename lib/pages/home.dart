import 'package:cerradura/pages/ContainerC.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          _pagina1(),
          _pagina3(context),
        ],
      ),
    );
  }

  Widget _pagina1() {
    return Stack(
      children: <Widget>[_colorFondo(), _imagenFondo(), _textos()],
    );
  }

  Widget _colorFondo() {
    return Container(
      color: Colors.white54,
      width: double.infinity,
      height: double.infinity,
    );
  }

  Widget _imagenFondo() {
    return Container(
        width: double.infinity,
      height: double.infinity,
      color: Colors.white,
     // padding: EdgeInsets.symmetric(vertical: 170.0, horizontal: 3.0),
      child: Image(
        image: AssetImage('assets/img/cerradura2.jpg'),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _textos() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(),
        ),
        
        Icon(
          Icons.keyboard_arrow_down,
          color: Color.fromRGBO(201, 156, 239, 100),
          size: 100.0,
        ),
      ],
    );
  }

  Widget _pagina3(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 60.0,
          ),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
              child: Text(
                'Control inteligente',
                style: TextStyle(color: Color.fromRGBO(201, 156, 239, 100), fontSize: 30.0),
              )),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
            child: Text(
                'Bienvenido, ya puedes comenzar a usar esta maravillosa aplicacion ',
                style: TextStyle(color: Color.fromRGBO(145, 121, 166, 50), fontSize: 20.0)),
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 30.0,
              ),
              Icon(
                Icons.bluetooth,
                size: 40.0,
                color: Color.fromRGBO(201, 156, 239, 100),
              ),
             
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
        
          RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              shape: StadiumBorder(),
              color: Color.fromRGBO(201, 156, 239, 100),
              textColor: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                child: Text(
                  "Menu Principal",
                  style: TextStyle(fontSize: 22.0),
                ),
              ),
              onPressed: () {
                final route = MaterialPageRoute(builder: (context) {
                  return ContainerC();
                  //FormularioTrabajador();
                });
                Navigator.push(context, route);
              }),
        ],
      ),
    );
  }
}
