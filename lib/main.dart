import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app_advanced/core/bloc/bloc_observer.dart';
import 'package:to_do_app_advanced/core/database/cache/cache_helper.dart';
import 'package:to_do_app_advanced/features/task/cubit/task_cubit.dart';

import 'app/app.dart';
import 'core/database/cache/sqflite_helper/sqflite_helper.dart';
import 'core/services/service_locater.dart';
import 'features/auth/data/presentation/cubit/task_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  setup();
  await sl<CacheHelper>().init();
  sl<SqfliteHelper>().intiDB();

  runApp(
    BlocProvider(
      create: (context) => TaskCubit()..getTasks(),
      child: MyApp(),
    ),
  );
}
