import 'package:appwrite/appwrite.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/repository/auth_repository.dart';
import '../../features/auth/presentation/blocs_cubits/login_cubit/login_cubit.dart';
import '../../features/home/data/repositories/home_recipes_repo.dart';
import '../../features/home/presentation/blocs_cubits/home_bloc.dart';
import '../../features/nav_bar/presentation/blocs_cubits/nav_bar_cubit.dart';
import '../../features/recipe_info/data/repositories/recipe_info_repo.dart';
import '../../features/recipe_info/presentation/bloc/recipe_info_bloc.dart';
import '../../features/search/data/repositories/search_repo.dart';
import '../../features/search/presentation/blocs_cubits/search_cubit/search_cubit.dart';
import '../../features/search/presentation/blocs_cubits/search_results_bloc/search_results_bloc.dart';
import '../blocs_cubits/app_lang_cubit/app_lang_cubit.dart';
import '../services/database_services/api/api_services.dart';
import '../services/database_services/api/app_write/app_write_init.dart';
import '../services/database_services/api/app_write/app_write_services.dart';
import '../services/database_services/api/dio/auth_services.dart';
import '../services/database_services/api/dio/dio_init.dart';
import '../services/database_services/api/dio/dio_services.dart';
import '../services/database_services/cache/cache_services.dart';
import '../services/database_services/cache/hive_consumer.dart';

final getIt = GetIt.instance;

Future<void> initServiceLocator() async {
  // App Write
  getIt
    ..registerLazySingleton<Client>(
      () => appWriteInit(),
    )
    ..registerLazySingleton<Account>(
      () => Account(getIt()),
    );

  // Data sources
  getIt.registerLazySingleton<Dio>(
    () => dioInit(),
  );

  // services
  getIt
    ..registerLazySingleton<CacheServices>(
      () => HiveConsumer(),
    )
    ..registerLazySingleton<ApiServices>(
      () => DioServices(getIt()),
    )
    ..registerLazySingleton<AuthServices>(
      () => AppWriteServices(getIt()),
    );

  // repositories
  getIt
    ..registerLazySingleton<AuthRepo>(
      () => AuthRepoImpl(getIt()),
    )
    ..registerLazySingleton<HomeRecipesRepo>(
      () => HomeRecipesRepoImpl(getIt()),
    )
    ..registerLazySingleton<RecipeInfoRepo>(
      () => RecipeInfoRepoImpl(getIt()),
    )
    ..registerLazySingleton<SearchRepo>(
      () => SearchRepoImpl(getIt()),
    );

  // cubits
  getIt
    ..registerLazySingleton<AppLangCubit>(
      () => AppLangCubit(),
    )
    ..registerLazySingleton<NavBarCubit>(
      () => NavBarCubit(),
    )
    ..registerLazySingleton<LoginCubit>(
      () => LoginCubit(),
    )
    ..registerLazySingleton<HomeBloc>(
      () => HomeBloc(),
    )
    ..registerFactory<RecipeInfoBloc>(
      () => RecipeInfoBloc(),
    )
    ..registerLazySingleton<SearchCubit>(
      () => SearchCubit(),
    )
    ..registerFactory<SearchResultsBloc>(
      () => SearchResultsBloc(),
    );
}
