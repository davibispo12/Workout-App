import 'package:app_academia/notifier/theme_notifier.dart';
import 'package:app_academia/notifier/treino_notifier.dart';
import 'package:app_academia/services/auth_service.dart';
import 'package:app_academia/services/theme_service.dart';
import 'package:app_academia/storage/hivestorageservice.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupLocator(){
getIt.registerSingleton<StorageService>(AuthTreinosService());
getIt.registerSingleton<TreinoNotifier>(TreinoNotifier());
getIt.registerSingleton<AuthService>(FirebaseService());
getIt.registerSingleton<ThemeNotifier>(ThemeNotifier());
getIt.registerSingleton<ThemeService>(Themeservice());

}