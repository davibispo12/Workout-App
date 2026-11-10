import 'package:app_academia/controllers/TreinoController.dart';
import 'package:app_academia/enums/grupo_muscular.dart';
import 'package:app_academia/models/exercicio.dart';
import 'package:app_academia/models/treino.dart';
import 'package:app_academia/utils/debouncer.dart';
import 'package:flutter/material.dart';

class VisualizarExercicios extends StatefulWidget {
  final Treino treino;
  const VisualizarExercicios({super.key, required this.treino});


  @override
  State<VisualizarExercicios> createState() => _VisualizarExerciciosState();
}

class _VisualizarExerciciosState extends State<VisualizarExercicios> {
  late List<Exercicio> resultadoBusca;
  late List<Exercicio> exercicios;
  final filtroGrupo = ValueNotifier<GrupoMuscular?>(null);
  bool buscando = false; 
  TextEditingController _buscandocontroller = TextEditingController();
  final debouncer = Debouncer(tempoDeEspera: Duration(milliseconds: 500));

 @override
 void initState(){
  super.initState();
  exercicios = widget.treino.exercicios;
  resultadoBusca = widget.treino.exercicios;
 }

 @override
 void dispose(){
 _buscandocontroller.dispose();
 debouncer.cancelar();
 filtroGrupo.dispose();
   super.dispose();
 }


  @override
  Widget build(BuildContext context) { 

    return Scaffold(

         appBar: AppBar(
        title: Text("Exercícios"),
        actions: [
          buscando 
          ? SizedBox(
            width: 200,
            child: TextField(
            controller: _buscandocontroller,
            onChanged: (texto){
              debouncer.executar((){
              final exerciciosEncontrados = exercicios.
              where((exercicio) => exercicio.nome.toLowerCase().contains(_buscandocontroller.text.toLowerCase())).toList();
              setState(() {
                resultadoBusca = exerciciosEncontrados;
              });
              });
            },
          ),
          )
          :IconButton(
            onPressed: (){
              setState(() {
                buscando = !buscando;
              });
            }, 
            
            icon: Icon(Icons.search)
            )
        ],
      ),

    body: Column(
    children:[
       Expanded(
        child: ValueListenableBuilder(
        valueListenable: filtroGrupo,
        builder: (context, musculoSelecionado, child){
        final musculoFiltrado = musculoSelecionado == null
        ? resultadoBusca
        : resultadoBusca.where((exercicio)=> exercicio.grupoMuscular == musculoSelecionado).toList();
        return Column(
        children: [
          Wrap(
            children: [
            ElevatedButton(onPressed: ()=> filtroGrupo.value = null, child: Text("Todos")),
            ElevatedButton(onPressed: ()=> filtroGrupo.value = GrupoMuscular.peito, child: Text("Peito")),
            ElevatedButton(onPressed: ()=> filtroGrupo.value = GrupoMuscular.costas, child: Text("Costas")),
            ElevatedButton(onPressed: ()=> filtroGrupo.value = GrupoMuscular.biceps, child: Text("Bíceps")),
            ElevatedButton(onPressed: ()=> filtroGrupo.value = GrupoMuscular.triceps, child: Text("Tríceps")),
            ElevatedButton(onPressed: ()=> filtroGrupo.value = GrupoMuscular.ombro, child: Text("Ombro")),
            ElevatedButton(onPressed: ()=> filtroGrupo.value = GrupoMuscular.pernas, child: Text("Pernas")),
            ],
          ),
          Expanded(
            child: ReorderableListView.builder(
            itemCount: musculoFiltrado.length,
            itemBuilder: (context, index){
             final exercicio = musculoFiltrado [index];
             return ListTile(
              key: ValueKey(exercicio.id),
              title: Text(exercicio.nome),
       );
      }, 
          onReorder: (int indiceAntigo, int indiceNovo){
           setState(() {

          final filtradaReordenada = List<Exercicio>.from(musculoFiltrado);
          if (indiceNovo > indiceAntigo) indiceNovo -= 1;
          final exercicioMovido = filtradaReordenada.removeAt(indiceAntigo);
          filtradaReordenada.insert(indiceNovo, exercicioMovido);
                 
          final slotsReais = <int>[];
          for (int i = 0; i < exercicios.length; i++){
           if ((musculoSelecionado== null || exercicios[i].grupoMuscular == musculoSelecionado) && resultadoBusca.contains(exercicios[i])){
            slotsReais.add(i);
           }}

          final novalistaCompleta = List<Exercicio>.from(exercicios);
          for(int i = 0; i< slotsReais.length; i++){
            novalistaCompleta[slotsReais[i]] = filtradaReordenada [i];
          }
          exercicios = novalistaCompleta;
          resultadoBusca= exercicios.where((exercicio)=> exercicio.nome.toLowerCase().contains(_buscandocontroller.text.toLowerCase())).toList();
           final treinoatualizado = widget.treino.copyWith(exercicios: exercicios);
           Treinocontroller().update(treinoatualizado);


        });
      }
      ),
          ),
        ],
        );
        }
        ),
       ),
      ]),
    );
  }
}