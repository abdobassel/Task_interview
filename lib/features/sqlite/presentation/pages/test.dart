import 'package:flutter/material.dart';
//import 'package:flutter_application_1/features/sqlite/data/models/person.dart';
import 'package:flutter_application_1/features/sqlite/presentation/cubit/sqlite_cubit.dart';
import 'package:flutter_application_1/features/sqlite/presentation/pages/person_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:country_icons/country_icons.dart';

class DataDisplayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Display'),
      ),
      body: BlocBuilder<SqliteCubit, SqliteState>(
        builder: (context, state) {
          if (state is AppSuccessGetDatabase) {
            List<Person> persons = state.persons;
            return ListView.builder(
              itemCount: persons.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Image.asset(
                        'icons/flags/png/${persons[index].nationalityID.toLowerCase()}.png',
                        package: 'country_icons',
                        width: 30,
                        height: 30,
                      ),
                    ),
                    title: Text('Name: ${persons[index].name}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Age: ${persons[index].age}'),
                        Text('Birthdate: ${persons[index].birthday}'),
                      ],
                    ),
                  ),
                );
              },
            );
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
