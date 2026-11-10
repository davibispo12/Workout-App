import 'package:app_academia/models/treino.dart';
import 'package:app_academia/service_locator/service_locator.dart';
import 'package:app_academia/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

abstract class StorageService{
Future<List<Treino>> buscarTreinos();
Future<void> salvarTreinos(List<Treino> treinos);
}

class HiveTreinosService implements StorageService{
  final box= Hive.box('PastaDeTreinos');

  @override
  Future <List<Treino>> buscarTreinos() async {
    final lista = box.get('treinos', defaultValue: []);
    return (lista as List)
    .map((caixa)=> Treino.fromJson(Map<String, dynamic>.from(caixa))).toList();
  }

  @override
  Future<void> salvarTreinos (List<Treino>treinos) async{
  final listaDeCaixas = treinos.map((t)=> t.toJson()).toList();
  await box.put('treinos', listaDeCaixas);
  }

}

class AuthTreinosService implements StorageService {
  
  @override 
  Future<List<Treino>> buscarTreinos() async {
    
   final idDoUsuario = getIt<AuthService>().identificacao()!;
   final gaveta = FirebaseFirestore.instance.collection('Usuarios').doc(idDoUsuario);
   final foto = await gaveta.get();

    if(!foto.exists){
      return [];
    }
    final lista = foto.data()!['treinos'] as List;
    return lista.map((caixa) => Treino.fromJson(Map<String, dynamic>.from(caixa))).toList();

    }
    @override 
    Future<void> salvarTreinos(List<Treino> treinos) async {
      final idDoUsuario = getIt<AuthService>().identificacao()!;
      final gaveta = FirebaseFirestore.instance.collection('Usuarios').doc(idDoUsuario);
         
       final listaDeTreino = treinos.map((T) => T.toJson()).toList();
        await gaveta.set ({'treinos': listaDeTreino});
    }
 


}
