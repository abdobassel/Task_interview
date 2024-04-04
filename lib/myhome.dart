import 'package:flutter/material.dart';
import 'package:country_icons/country_icons.dart';
import 'package:flutter_application_1/features/sqlite/presentation/cubit/sqlite_cubit.dart';
import 'package:flutter_application_1/features/sqlite/presentation/pages/person_model.dart';
import 'package:flutter_application_1/personbuider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final sqliteCubit = SqliteCubit.get(context);
    sqliteCubit.getDataFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: BlocBuilder<SqliteCubit, SqliteState>(
        builder: (context, state) {
          if (state is AppSuccessGetDatabase) {
            return PersonItemBuilder(persons: state.persons);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
