import 'package:dio/dio.dart';
import 'package:flutter_weather_app/core/platform/network_info.dart';
import 'package:flutter_weather_app/feature/data/datasources/city_local_data_source.dart';
import 'package:flutter_weather_app/feature/data/datasources/city_remote_data_source.dart';
import 'package:flutter_weather_app/feature/data/datasources/weather_local_data_source.dart';
import 'package:flutter_weather_app/feature/data/datasources/weather_remote_data_source.dart';
import 'package:flutter_weather_app/feature/data/repositories/city_repository_impl.dart';
import 'package:flutter_weather_app/feature/data/repositories/weather_repository_impl.dart';
import 'package:flutter_weather_app/feature/domain/repositories/city_repository.dart';
import 'package:flutter_weather_app/feature/domain/repositories/weather_repository.dart';
import 'package:flutter_weather_app/feature/domain/usecases/get_all_city.dart';
import 'package:flutter_weather_app/feature/domain/usecases/get_city_weather.dart';
import 'package:flutter_weather_app/feature/domain/usecases/get_last_city.dart';
import 'package:flutter_weather_app/feature/domain/usecases/save_city.dart';
import 'package:flutter_weather_app/feature/domain/usecases/search_cities.dart';
import 'package:flutter_weather_app/feature/presentation/city_bloc/city_bloc.dart';
import 'package:flutter_weather_app/feature/presentation/weather_bloc/weather_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// service locator
final GetIt sl = GetIt.instance;

Future<void> init() async {
  // BLoC / Cubit
  sl.registerLazySingleton(
    () => CityBloc(
      getAllCity: sl(),
      searchCities: sl(),
      saveCity: sl(),
      getLastCity: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => WeatherBloc(
      getCityWeather: sl(),
    ),
  );

  // UseCases
  sl.registerLazySingleton(() => GetAllCity(sl()));
  sl.registerLazySingleton(() => SearchCities(sl()));
  sl.registerLazySingleton(() => GetCityWeather(sl()));
  sl.registerLazySingleton(() => SaveCity(sl()));
  sl.registerLazySingleton(() => GetLastCity(sl()));

  // Repository
  sl.registerLazySingleton<CityRepository>(
    () => CityRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      remoteDataSource: sl(),
      localeDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<CityRemoteDataSource>(
    () => CityRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<CityLocalDataSource>(
    () => CityLocalDataSourceImpl(sharedPreferences: sl()),
  );

  sl.registerLazySingleton<WeatherLocalDataSource>(
    () => WeatherLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );

  // External

  // need to change default address https://github.com/RounakTadvi/internet_connection_checker/issues/24
  InternetConnectionChecker().addresses = [
    AddressCheckOptions(hostname: 'google.com', port: 80)
  ];

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
