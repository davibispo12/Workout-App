import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ThemeService {
Future<void> salvarTema (ThemeMode tema);
Future<ThemeMode?> buscarTema();
}

 class Themeservice implements ThemeService {

 @override
 Future <void> salvarTema (ThemeMode tema) async{
    final bloco = await SharedPreferences.getInstance();
   await bloco.setString('tema', tema.name);
 }

 @override
 Future <ThemeMode?> buscarTema() async {
   final bloco = await SharedPreferences.getInstance();
   final texto = bloco.getString('tema');
   if (texto == null) return null;
   return ThemeMode.values.byName(texto);

   }
 }