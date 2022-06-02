import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rick_and_morty/core/platform/network_info.dart';
import 'package:rick_and_morty/feature/data/datasources/person_local_data_sources.dart';
import 'package:rick_and_morty/feature/data/datasources/person_remote_data_source.dart';
import 'package:rick_and_morty/feature/data/repository/person_repository_impl.dart';
import 'package:rick_and_morty/feature/domain/repository/person_repository.dart';
import 'package:rick_and_morty/feature/domain/usecaseces/get_all_persons.dart';
import 'package:rick_and_morty/feature/domain/usecaseces/search_person.dart';
import 'package:rick_and_morty/feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


final sl = GetIt.instance;


Future<void> init() async {
  sl.registerFactory(() => PersonListCubit(getAllPersons: sl()));
  sl.registerFactory(() => PersonSearchBloc(searchPerson: sl()));

  sl.registerLazySingleton(() => GetAllPersons(sl()));
  sl.registerLazySingleton(() => SearchPerson(sl()));

  sl.registerLazySingleton<PersonRepository>(
    () => PersonRepositoryImpl(
       sl(), sl(), sl(),
      ),
      );

      sl.registerLazySingleton<PersonRemoteDataSource>(
        () => PersonRemoteDataSourceImpl(client: http.Client())
        );

        sl.registerLazySingleton<PersonLocalDataSource>(() => PersonLocalDataSourceImpl(sharedPreferences: sl()));
    
    sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

    final sharedPreferenses = await SharedPreferences.getInstance(); 
    
    sl.registerLazySingleton(() => sharedPreferenses);
    sl.registerLazySingleton(() => http.Client());
    sl.registerLazySingleton(() => InternetConnectionChecker());

}