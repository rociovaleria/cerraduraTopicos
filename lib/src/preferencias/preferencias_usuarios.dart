import 'package:shared_preferences/shared_preferences.dart';
class PreferenciasUsuario {

  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del nombre

    get password {
    return _prefs.getString('password') ?? '';
  }

  set password( String value ) {
    _prefs.setString('password', value);
  }
    get name {
    return _prefs.getString('name') ?? '';
  }

  set name( String value ) {
    _prefs.setString('name', value);
  }
    get direccion {
    return _prefs.getString('direccion') ?? '';
  }

  set direccion( String value ) {
    _prefs.setString('direccion', value);
  }

  get estadoConexion {
    return _prefs.getBool('estadoConexion') ?? false;
  }

  set estadoConexion( bool value ) {
    _prefs.setBool('estadoConexion', value);
  }


}

