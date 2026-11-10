import 'package:app_academia/models/treino.dart';
import 'package:app_academia/notifier/treino_notifier.dart';
import 'package:app_academia/service_locator/service_locator.dart';
import 'package:app_academia/storage/hivestorageservice.dart';

class Treinocontroller {
final TreinoNotifier notifier = getIt<TreinoNotifier>();
final StorageService service = getIt<StorageService>();

Future<void> add (Treino treino) async{
 final listaNova = [...notifier.value,treino];
 await service.salvarTreinos(listaNova);
 notifier.value = listaNova;
}

Future<void> remove (String id) async{
 final listaNova = notifier.value.where((t)=> t.id != id).toList();
 await service.salvarTreinos(listaNova);
 notifier.value = listaNova;
}

Future<void> update (Treino treinoatualizado) async {
 final listaNova = notifier.value.map((t){
    if (t.id == treinoatualizado.id){
       return treinoatualizado;
    }
    return t;
 }).toList();
 await service.salvarTreinos(listaNova);
 notifier.value = listaNova;
}

void reorder (int indiceAntigo, int indiceNovo){
 final listaNova = [...notifier.value];
 final item = listaNova.removeAt(indiceAntigo);
 listaNova.insert(indiceNovo, item);
 notifier.value = listaNova;
}

Future<void> carregar () async {
 final treinoColetado = await service.buscarTreinos();
 notifier.value = treinoColetado;

}

}