
import 'package:app_academia/notifier/treino_notifier.dart';
import 'package:app_academia/service_locator/service_locator.dart';
import 'package:app_academia/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Authcontroller {
final AuthService authController = getIt<AuthService>();
final TreinoNotifier notifier = getIt<TreinoNotifier>();

Future<void> login (String email, String senha) async{
 await authController.login(email, senha);

}

Future<void> cadastro(String email, String senha) async{
 await authController.cadastro( email, senha);
}

Future <void> sair () async{
 await authController.sair();
  notifier.value = [];
}

Stream <User?> estadoDoLogin (){
 return authController.estadoDoLogin();

}

}
