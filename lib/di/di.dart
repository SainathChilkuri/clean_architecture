import 'package:clean_architecture/Features/data/datasources/local%20repo/local_datasource.dart';
import 'package:clean_architecture/Features/data/datasources/remote%20repo/remote_number_data_source.dart';
import 'package:clean_architecture/Features/data/repositories/number_repo_impl.dart';
import 'package:clean_architecture/Features/domain/repositories/number_repository.dart';
import 'package:clean_architecture/Features/domain/usecases/number_usecase.dart';
import 'package:clean_architecture/Features/presentation/bloc/NumberBloc/number_bloc.dart';
import 'package:clean_architecture/core/Network/network_info.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
final sl = GetIt.instance;
 Future<void> init() async {
   //Bloc
   sl.registerFactory(
           () => NumberBloc(numberUseCase: sl()));
   //UseCase
   sl.registerLazySingleton(() => NumberUseCase(numberRepository: sl()));
   //Repository
   sl.registerLazySingleton<NumberRepository>(
           () => NumberRepoImpl(
               localDataSource: sl(),
               remoteDataSource: sl(),
               networkInfo: sl()));
   //local
   sl.registerLazySingleton<LocalDataSource>(
           () => LocalDataSourceImpl(sharedPreferences: sl()));
   //remote
   sl.registerLazySingleton<RemoteSourceData>(
           () => RemoteDataSourceImpl(dio: sl()));
   //data connection
   sl.registerLazySingleton(() => DataConnectionChecker());
   //network
   sl.registerLazySingleton<NetworkInfo>(
           () => NetworkInfoImpl(dataConnectionChecker: sl()));
   //shared
   var sharedPref = await SharedPreferences.getInstance();
   sl.registerLazySingleton<SharedPreferences>(
           () => sharedPref);
   sl.registerLazySingleton(() => Dio());
 }