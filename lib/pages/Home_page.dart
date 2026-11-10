import 'package:app_academia/controllers/AuthController.dart';
import 'package:app_academia/controllers/ThemeController.dart';
import 'package:app_academia/controllers/TreinoController.dart';
import 'package:app_academia/models/treino.dart';
import 'package:app_academia/pages/Treino_novo.dart';
import 'package:app_academia/pages/Visualizar_exercicios.dart';
import 'package:flutter/material.dart';

class Home_page extends StatefulWidget {
  const Home_page({super.key});

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
     @override
    void initState() {
    super.initState();
    Treinocontroller().carregar();
  }
    
  @override
  Widget build(BuildContext context) {
 
    return DefaultTabController(
      length: 3, 
      child: Scaffold( 
      appBar: AppBar(
        title: Text("App Academia"),
        actions: [
          IconButton(
            onPressed: (){
              Authcontroller().sair();
            },
             icon: Icon(Icons.logout)
             ),
          IconButton(
            onPressed: (){
             final temaNovo = Themecontroller().themenotifier.value == ThemeMode.dark
             ? ThemeMode.light
             : ThemeMode.dark;
             Themecontroller().trocar(temaNovo);
            }, 
            icon: Icon(Icons.brightness_6)
            )
        ],
        bottom: TabBar(
          tabs: [
            Tab(text: 'Treino',),
            Tab(text: 'Historico',),
            Tab(text: 'Progresso'),
          ]

          
          ),
      ),
       body: 
      TabBarView(
        children: [
          ValueListenableBuilder<List<Treino>>(
          valueListenable: Treinocontroller().notifier, 
          builder: (context, listaDeTreinos, child){
            return ListView.builder(
              itemCount: listaDeTreinos.length,
              itemBuilder: (context, index) {
                final treino = listaDeTreinos[index];
                return ListTile(
                  title: Text(treino.dia),
                  trailing: Row(
                     mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context)=>VisualizarExercicios(treino: treino))
                        );
                      }, 
                      child: Text("Vizualizar exercícios")
                      ),
                   ElevatedButton(
                     onPressed: (){Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context)=> TreinoNovo(treinoParaEditar: treino,))
                       );},
                      child: Text('Editar')
                      ),
          
                   ElevatedButton(
                    onPressed: (){Treinocontroller().remove(treino.id);}, 
                    child: Text("Excluir")
                    )
                    ])
                    
                );
              },
            );
          }
          ),
          Text("em breve"),
          Text('em breve')                    
        ],
      ),
      floatingActionButton: 
       FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => TreinoNovo(),)
            );
            },
        child: Icon(Icons.add)
        
        ),
      ));
  }
}