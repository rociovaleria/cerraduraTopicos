import 'package:local_auth/local_auth.dart';

class FingerPrintValidatorFacade {
  static Future<bool> validate() async {
    final LocalAuthentication _localAuthentication = LocalAuthentication();
    bool canCheckBiometric = false;
    try {
      canCheckBiometric = await _localAuthentication.canCheckBiometrics;
    } catch (e) {
      print("No hay dispositivos de verificacion biometrica" + e);
      return false;
    }

    if (!canCheckBiometric) return false;

    bool isAuthorized = false;
    try {
      isAuthorized = await _localAuthentication.authenticateWithBiometrics(
        localizedReason:
            "Por favor se requiere autenticacion biometrica para completar la accion",
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } catch (e) {
      print("Ocurrio un error durante la autenticacion " + e);
      return false;
    }

    return isAuthorized;
  }
}
