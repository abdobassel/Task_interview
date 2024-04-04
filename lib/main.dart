import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/sqlite/presentation/cubit/observer.dart';
import 'package:flutter_application_1/features/sqlite/presentation/cubit/sqlite_cubit.dart';
import 'package:flutter_application_1/features/sqlite/presentation/pages/FormScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SqliteCubit>(
        create: (context) => SqliteCubit()..createDatabase(),
        child: BlocConsumer<SqliteCubit, SqliteState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: FormInsertPage(),
            );
          },
        ));
  }
}
