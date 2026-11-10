import 'package:app_academia/controllers/ThemeController.dart';
import 'package:app_academia/firebase_options.dart';
import 'package:app_academia/notifier/theme_notifier.dart';
import 'package:app_academia/pages/porteiro_page.dart';
import 'package:app_academia/service_locator/service_locator.dart';
import 'package:app_academia/theme/Theme_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  await Hive.openBox('PastaDeTreinos');
  setupLocator();
  await Themecontroller().carregar();
  
  runApp(ValueListenableBuilder(
    valueListenable: getIt<ThemeNotifier>(), 
    builder: (context, tema, child){
     return MaterialApp(
     theme: temaClaroApp,
     darkTheme: temaEscuroApp,
     debugShowCheckedModeBanner: false,
     themeMode: tema,
      home: PorteiroPage()
     );
    }
    ));

}  