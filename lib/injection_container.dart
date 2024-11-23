import 'package:bonne_reponse/src/authentication/services/auth_service.dart';
import 'package:bonne_reponse/src/http/http_client.dart';
import 'package:bonne_reponse/src/user/infra/user_repo.dart';
import 'package:bonne_reponse/src/user/services/user_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator() {
  // Services
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => UserService());

  // API
  locator.registerLazySingleton<HttpClient>(() => HttpClientImpl(locator()));

  //External
  locator.registerLazySingleton(() => Dio());

  // Repository
  locator.registerLazySingleton(() => UserRepository());
}
