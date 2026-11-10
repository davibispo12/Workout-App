import 'package:app_academia/notifier/theme_notifier.dart';
import 'package:app_academia/service_locator/service_locator.dart';
import 'package:app_academia/services/theme_service.dart';
import 'package:flutter/material.dart';

class Themecontroller {
 final ThemeService themeService = getIt<ThemeService>();
 final ThemeNotifier themenotifier = getIt<ThemeNotifier>();

 Future <void> trocar (ThemeMode tema)async {
   themenotifier.value = tema;
    await themeService.salvarTema(tema);
 }
 Future<void> carregar ()async {
   final temaSalvo = await themeService.buscarTema();
   if (temaSalvo != null){
     themenotifier.value = temaSalvo;
   }
 }














}
