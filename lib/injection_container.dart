import 'package:bonne_reponse/src/application/auth_service.dart';
import 'package:bonne_reponse/src/infra/account/user_repo.dart';
import 'package:bonne_reponse/src/infra/http_client.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator() {
  // Services
  locator.registerLazySingleton(() => AuthService());

  // API
  locator.registerLazySingleton<HttpClient>(() => HttpClientImpl(locator()));


  //External
    locator.registerLazySingleton(() => Dio());

  // Repository
  locator.registerLazySingleton(() => UserRepository());
}
