import 'package:app_academia/controllers/TreinoController.dart';
import 'package:app_academia/enums/grupo_muscular.dart';
import 'package:app_academia/models/exercicio.dart';
import 'package:app_academia/models/treino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TreinoNovo extends StatefulWidget {
  final Treino? treinoParaEditar;
  const TreinoNovo({super.key, this.treinoParaEditar});


  @override
  State<TreinoNovo> createState() => _TreinoNovoState();
}

class _TreinoNovoState extends State<TreinoNovo> {
 final TextEditingController _diacontroller = TextEditingController();
 final TextEditingController _nomecontroller = TextEditingController();
 final TextEditingController _seriescontroller = TextEditingController();
 final TextEditingController _repeticoescontroller = TextEditingController();
 final TextEditingController _cargacontroller = TextEditingController();
 final _formkeyAdicionarExercicio = GlobalKey<FormState>();
 final _formkeysalvar = GlobalKey<FormState>();
 final _focusSeries = FocusNode();
 final _focusRepeticoes = FocusNode();
 final _focusCarga = FocusNode();
 
 @override
 void initState(){
  super.initState();
  if (widget.treinoParaEditar != null){
    _diacontroller.text = widget.treinoParaEditar!.dia;
    exerciciosAdicionados = widget.treinoParaEditar!.exercicios;
  }
 }
 @override
 void dispose (){
 _cargacontroller.dispose();
 _diacontroller.dispose();
 _nomecontroller.dispose();
 _repeticoescontroller.dispose();
 _seriescontroller.dispose();
 _focusCarga.dispose();
 _focusRepeticoes.dispose();
 _focusSeries.dispose();
 super.dispose();
 }




 GrupoMuscular? grupoMuscularSelecionado;
 List<Exercicio> exerciciosAdicionados = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Column(
      children: [
        Form(
          key: _formkeyAdicionarExercicio,
          child: Column(
          children: [
            TextFormField(
        controller: _nomecontroller,
        onFieldSubmitted: (valor){
            FocusScope.of(context).requestFocus(_focusSeries);
          },
        validator: (valor){
          if(valor == null || valor.isEmpty){
           return "Preenche esse campo";
          }
           return null;
        },
        decoration: InputDecoration(
          hintText: "Nome"
          ),), SizedBox(height: 16,),

        TextFormField(
          controller: _seriescontroller,
          focusNode: _focusSeries,
          onFieldSubmitted: (valor){
            FocusScope.of(context).requestFocus(_focusRepeticoes);
          },
           validator: (valor){
          if(valor == null || valor.isEmpty){
           return "Preenche esse campo";
          }
           if(int.tryParse(valor) == null){
             return "Digita um número válido";
         }
         
           return null;
        },
          decoration: InputDecoration(
           hintText: "Séries" 
            )),SizedBox(height: 16,),

        TextFormField(
          controller: _repeticoescontroller,
          focusNode: _focusRepeticoes,
            onFieldSubmitted: (valor){
            FocusScope.of(context).requestFocus(_focusCarga);
          },
           validator: (valor){
          if(valor == null || valor.isEmpty){
           return "Preenche esse campo";
          }
           if(int.tryParse(valor) == null){
             return "Digita um número válido";
         }
           return null;
        },
          decoration: InputDecoration(
            hintText: "Repetições" 
            ),),SizedBox(height: 16,),

        TextFormField(
          controller: _cargacontroller,
          focusNode: _focusCarga,
           validator: (valor){
          if(valor == null || valor.isEmpty){
           return "Preenche esse campo";
          }
           if(double.tryParse(valor) == null){
             return "Digita um número válido";
         }
           return null;
        },
          decoration: InputDecoration(
             hintText: "Carga" 
            ),),SizedBox(height: 16,),

             DropdownButtonFormField(
               validator: (valor){
          if(valor == null){
           return "Preenche esse campo";
          }
          
         
           return null;
        },
        value: grupoMuscularSelecionado,
        items: GrupoMuscular.values.map((musculo){
        return DropdownMenuItem(
          value: musculo,
          child: Text(musculo.name)
          );

        }).toList(), 
        onChanged: (novomusculo){
          setState(() {
            grupoMuscularSelecionado = novomusculo;
          });
        }

        )
          ]

         
        ),
        
        
        ),
        
        Form(
          key: _formkeysalvar,
          child: 
          TextFormField(
          controller: _diacontroller,
           validator: (valor){
          if(valor == null || valor.isEmpty){
           return "Preenche esse campo";
          }
          return null;
        },
          decoration: InputDecoration(
            hintText: "Dia"
           ),),
          ),SizedBox(height: 16,),
        

       
        ElevatedButton(
          onPressed: (){
            if(_formkeyAdicionarExercicio.currentState!.validate()){

           final novoExercicio =  Exercicio(
              id: Uuid().v4(),
              nome: _nomecontroller.text, 
              grupoMuscular: grupoMuscularSelecionado! , 
              series: int.parse(_seriescontroller.text), 
              repeticoes: int.parse(_repeticoescontroller.text), 
              carga: double.parse(_cargacontroller.text),
              );
              setState(() {
                exerciciosAdicionados = [...exerciciosAdicionados, novoExercicio];
              });}
          }, 
          child: Text("Adicionar Exercício")
           ),SizedBox(height: 16,),

        ElevatedButton(
          onPressed: (){
            if(_formkeysalvar.currentState!.validate()){
            if(widget.treinoParaEditar == null){
              final treinoNovo = Treino(
              id: Uuid().v4(),
              dia: _diacontroller.text, 
              exercicios: exerciciosAdicionados
              );
              Treinocontroller().add(treinoNovo);
              }
              else {
                final treinoatualizado = widget.treinoParaEditar!.copyWith(
                  dia: _diacontroller.text,
                  exercicios: exerciciosAdicionados
                );
                Treinocontroller().update(treinoatualizado);
                
              }
              Navigator.pop(context);
          }}, 
          child: Text("Salvar")
          )
      ],
    ),

    );
  }
}