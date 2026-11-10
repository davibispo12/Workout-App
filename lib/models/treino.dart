import 'package:app_academia/models/exercicio.dart';

class Treino {
 final String id;
 final String dia;
 final List <Exercicio> exercicios;
 Treino({required this.id, required this.dia, required this.exercicios});

 factory Treino.fromJson(Map<String, dynamic> json){
 return Treino(
  id: json["id"],
  dia: json["dia"],
  exercicios: (json['exercicio'] as List).map((caixa)=>Exercicio.fromJson(Map<String, dynamic>.from(caixa))).toList()
 );
 }

 Map<String, dynamic> toJson (){
 return{
  'id': id,
  'dia': dia,
  'exercicio': exercicios.map((exercicio) => exercicio.toJson()).toList(),
 };
 }

Treino copyWith ({String? id, String? dia, List<Exercicio>? exercicios}){
 return Treino(
  id: id ?? this.id,
  dia: dia ?? this.dia,
  exercicios: exercicios ?? this.exercicios,
  

  );

}

}