import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
Future<void> login (String emailUsuario, String senhaUsuario);
Future<void> sair ();
String? identificacao ();
Future<void> cadastro (String emailUsuario, String senhaUsuario);
Stream<User?> estadoDoLogin();
}

class FirebaseService implements AuthService {

@override
Future<void> login (String emailUsuario, String senhaUsuario) async{
  await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailUsuario, password: senhaUsuario);
}

@override
Future<void> cadastro (String emailUsuario, String senhaUsuario) async {
  await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailUsuario, password: senhaUsuario);
}

@override
Future<void> sair ()async {
    await FirebaseAuth.instance.signOut();
}

@override
String? identificacao() {
   return FirebaseAuth.instance.currentUser?.uid;
}

@override
 Stream<User?> estadoDoLogin(){
 return FirebaseAuth.instance.authStateChanges();

  }
  

}