import 'package:get_it/get_it.dart';
import 'package:khetma/controllers/home/home_bloc.dart';
import 'package:khetma/data/data_source/shared_pref/shared_pref_data_source.dart';
import 'package:khetma/data/repository/cache_repo_shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/quran/quran_bloc.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // app module, its a module where we put all generic dependencies

  // shared prefs instance
  SharedPreferences shared = await SharedPreferences.getInstance();

  // repo cache
  instance.registerLazySingleton(() => SharedPrefDSImpl(shared));

  instance.registerLazySingleton(
      () => CacheRepoSharedPref(instance<SharedPrefDSImpl>()));

  // blocs
  instance.registerLazySingleton(() => QuranBloc());
  instance<QuranBloc>().init();
  instance
      .registerLazySingleton(() => HomeBloc(instance<CacheRepoSharedPref>()));
  instance<HomeBloc>().init();
}

// initQuranModule() {
//   if (!GetIt.I.isRegistered<GetAllQuranUseCase>()) {
//
//   }
// }
