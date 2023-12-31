import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nested/nested.dart';

import 'core/blocs_cubits/app_lang_cubit/app_lang_cubit.dart';
import 'core/blocs_cubits/bloc_observer.dart';
import 'core/utils/app_constants.dart';
import 'core/utils/app_strings.dart';
import 'core/utils/service_locator.dart';
import 'features/home/presentation/blocs_cubits/home_bloc.dart';
import 'features/nav_bar/presentation/blocs_cubits/nav_bar_cubit.dart';
import 'firebase_options.dart';
import 'my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _appInit();
  runApp(
    MultiBlocProvider(
      providers: _providers(),
      child: const MyApp(),
    ),
  );
}

List<SingleChildWidget> _providers() {
  return [
    BlocProvider<AppLangCubit>(
      create: (context) => getIt<AppLangCubit>(),
    ),
    BlocProvider<NavBarCubit>(
      create: (context) => getIt<NavBarCubit>(),
    ),
    BlocProvider<HomeBloc>(
      create: (context) => getIt<HomeBloc>(),
    ),
  ];
}

Future<void> _appInit() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
  await dotenv.load(fileName: ".env");
  await _hiveInit();
  await initServiceLocator();
  AppConstants.appLocalizations = await getIt<AppLangCubit>().initAppLocale();
}

Future<void> _hiveInit() async {
  await Hive.initFlutter();
  await Future.wait([
    Hive.openBox(AppStrings.hiveFavoriteBox),
    Hive.openBox(AppStrings.hiveLoginBox),
    Hive.openBox(AppStrings.hiveAppLocaleBox),
  ]);
}
