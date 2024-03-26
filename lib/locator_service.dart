import 'package:dio/dio.dart';
import 'package:flutter_weather_app/core/platform/network_info.dart';
import 'package:flutter_weather_app/feature/data/datasources/city_local_data_source.dart';
import 'package:flutter_weather_app/feature/data/datasources/city_remote_data_source.dart';
import 'package:flutter_weather_app/feature/data/repositories/city_repository_impl.dart';
import 'package:flutter_weather_app/feature/domain/repositories/city_repository.dart';
import 'package:flutter_weather_app/feature/domain/usecases/get_all_city.dart';
import 'package:flutter_weather_app/feature/presentation/city_bloc/city_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// service locator
final GetIt sl = GetIt.instance;

Future<void> init() async {
  // BLoC / Cubit
  sl.registerFactory(
    () => CityBloc(
      getAllCity: sl(),
    ),
  );

  // UseCases
  sl.registerLazySingleton(() => GetAllCity(sl()));

  // Repository
  sl.registerLazySingleton<CityRepository>(
    () => CityRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<CityRemoteDataSource>(
    () => CityRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<CityLocalDataSource>(
    () => CityLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );

  // External

  // need to change default address https://github.com/RounakTadvi/internet_connection_checker/issues/24
  InternetConnectionChecker().addresses = [AddressCheckOptions(hostname: 'google.com', port: 80)];

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
