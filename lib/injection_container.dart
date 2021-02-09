import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:reviewapp/core/network/network_info.dart';
import 'package:reviewapp/features/review/data/datasources/review_local_data_source.dart';
import 'package:reviewapp/features/review/data/repositories/review_repository_impl.dart';
import 'package:reviewapp/features/review/domain/repositories/review_repository.dart';
import 'package:reviewapp/features/review/domain/usecases/get_reviews_uc.dart';
import 'package:reviewapp/features/review/domain/usecases/save_review_uc.dart';
import 'package:reviewapp/features/review/presentation/store/review_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

// registerFactory sempre instancia uma nova classe
// registerLazySingleton sempre retorna a mesma instancia da classe SOMENTE QUANDO FOR REQUISITADO
// registerSingletonsempre retorna a mesma instancia da classe SEMPRE QUANDO O APP FOI INICIADO

Future<void> init() async {
  // Features > Number Trivia
  sl.registerFactory(() => ReviewStore(
        getReviewUC: sl(),
        saveReviewUC: sl(),
      ));

  sl.registerLazySingleton(() => GetReviewUC(sl()));
  sl.registerLazySingleton(() => SaveReviewUC(sl()));

  sl.registerLazySingleton<ReviewRepository>(() => ReviewRepositoryImpl(
        localDataSource: sl(),
        networkInfo: sl(),
      ));

  sl.registerLazySingleton<ReviewLocalDataSource>(
      () => ReviewLocalDataSourceImpl(sl()));

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
