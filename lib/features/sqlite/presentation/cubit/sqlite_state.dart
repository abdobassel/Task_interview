part of 'sqlite_cubit.dart';

abstract class SqliteState extends Equatable {
  const SqliteState();

  @override
  List<Object> get props => [];
}

class SqliteInitial extends SqliteState {}

class AppCreateDatabase extends SqliteState {}

class AppInsertDatabase extends SqliteState {}

class AppLoadingDatabase extends SqliteState {}

class AppSuccessGetDatabase extends SqliteState {
  List<Person> persons;
  AppSuccessGetDatabase(this.persons);
}

class AppErrorGetDatabase extends SqliteState {}
