import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/sqlite/presentation/pages/person_model.dart';

class PersonItemBuilder extends StatelessWidget {
  PersonItemBuilder({super.key, required this.persons});
  final List<Person> persons;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: persons.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(
              persons[index].name,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            subtitle: Text(
              'NationalID: ${persons[index].nationalityID}',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            leading: CircleAvatar(
              child: Icon(Icons.person_3_rounded),
              radius: 20,
            ),
          ),
        );
      },
    );
  }
}
