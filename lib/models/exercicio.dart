import 'package:app_academia/enums/grupo_muscular.dart';

class Exercicio {
final String id;
final String nome;
final GrupoMuscular grupoMuscular;
final int series;
final int repeticoes;
final double carga;
Exercicio ({required this.nome, required this.grupoMuscular, required this.series, required this.repeticoes, required this.carga, required this.id});
 
 factory Exercicio.fromJson (Map<String, dynamic> json){
  return Exercicio(
    id: json['id'] ,
    nome: json['nome'], 
    grupoMuscular: GrupoMuscular.values.byName(json['grupoMuscular']), 
    series: json ['series'], 
    repeticoes: json['repeticoes'], 
    carga: json ['carga']
    );
 }

 Map<String, dynamic> toJson(){
return{
  'id': id,
  'nome': nome,
  'grupoMuscular': grupoMuscular.name,
  'series': series,
  'repeticoes': repeticoes,
  'carga': carga
};
 }

 Exercicio copyWith ({String? nome, GrupoMuscular? grupoMuscular, int? series, int? repeticoes, double? carga, String? id}){
  
  return Exercicio(
  id: id ?? this.id,
  nome: nome ?? this.nome,
  grupoMuscular: grupoMuscular ?? this.grupoMuscular,
  series: series ?? this.series,
  repeticoes: repeticoes ?? this.repeticoes,
  carga: carga ?? this.carga
  );
 }


}