import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/features/sqlite/presentation/pages/person_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

part 'sqlite_state.dart';

class SqliteCubit extends Cubit<SqliteState> {
  SqliteCubit() : super(SqliteInitial());
  static SqliteCubit get(context) => BlocProvider.of(context);

  Database? database;
  void createDatabase() {
    openDatabase(
      'Interview.db',
      version: 1,
      onCreate: (Database database, int version) async {
        // When creating the db, create the table
        await database
            .execute(
                'CREATE TABLE Person (id INTEGER PRIMARY KEY, name TEXT, age int, nationalityID int,birthDate TEXT)')
            .then((value) {
          print('crated table');
        });
        print('createed db');

        await database.execute(
            '''
   create table Nationality  (
    personId integer primary key autoincrement,
    name text not null
   )''');
        //  print(database);
      },
      onOpen: (database) {},
    ).then((value) {
      database = value;
      emit(AppCreateDatabase());
      print(value);
    });
  }

  void insertDataToDatabase({
    required String name,
    required String age,
    required String nationalityID,
    required String birthday,
  }) async {
    insertPerson(
      name: name,
      age: age,
      nationalityId: nationalityID,
      birthday: birthday,
    ).then((value) {
      emit(AppInsertDatabase());
      print("Suscess");
    });

    // إدراج البيانات في جدول الجنسيات (Nationality)
    await insertNationality(name: nationalityID.toString()).then((value) {
      print("Suscess nathid");
    });
  }

  Future<void> insertPerson(
      {required String name,
      required String nationalityId,
      required String age,
      required String birthday}) async {
    return await database?.transaction((txn) async {
      try {
        txn
            .rawInsert(
                'INSERT INTO Person (name,age,nationalityID,birthDate) VALUES ("$name","$age","$nationalityId","$birthday")')
            .then((value) {
          print(value);
          emit(AppInsertDatabase());
          //   getDatabase(database);
        });
        print('inserted database');
      } catch (error) {
        print('error is ${error.toString()}');
      }
    });
  }

  Future<void> insertNationality({required String name}) async {
    await database?.transaction((txn) async {
      try {
        await txn.rawInsert(
          'INSERT INTO Nationality (name) VALUES (?)',
          [name],
        );
        emit(AppInsertDatabase());
        print('Inserted into Nationality table');
      } catch (error) {
        print('Error inserting into Nationality table: ${error.toString()}');
      }
    });
  }

  Future<List<Person>> getDataFromDatabase() async {
    emit(AppLoadingDatabase());
    List<Person> persons = [];

    try {
      final List<Map<String, dynamic>> data = await database!.query('Person');

      // تحويل البيانات المسترجعة إلى قائمة من أشخاص
      persons = List.generate(data.length, (i) {
        return Person(
          id: data[i]['id'],
          name: data[i]['name'],
          age: data[i]['age'],
          nationalityID: data[i]['nationalityID'],
          birthday: data[i]['birthDate'],
        );
      });

      emit(AppSuccessGetDatabase(persons));
    } catch (error) {
      print('Error getting data from database: ${error.toString()}');
      emit(AppErrorGetDatabase());
    }

    return persons;
  }
}
