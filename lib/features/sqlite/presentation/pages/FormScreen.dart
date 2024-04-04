import 'package:flutter/material.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter_application_1/components.dart';
import 'package:flutter_application_1/features/sqlite/presentation/cubit/sqlite_cubit.dart';
import 'package:flutter_application_1/myhome.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:intl/intl.dart';

class FormInsertPage extends StatelessWidget {
  FormInsertPage({Key? key});
  var name = TextEditingController();

  var nationalityID = TextEditingController();

  /*
  task
  
	bind it to [Person] table from database with a binding source
	Add all fields with retrive command
	insert some fields
	make the nationality field use Search Edit Lookup edit and the nationalityID as the value field
	insert data navigator control
   */

  var age = TextEditingController();
  var birthDate = TextEditingController();
  var formKey = GlobalKey<FormState>();
  Country? selectedCountry;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SqliteCubit, SqliteState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SqliteCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: Icon(Icons.home))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      'Task',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        DefaultTextForm(
                            controller: name,
                            labeltext: "name",
                            validate: (value) {
                              if (value != null) {
                                if (value!.isEmpty) {
                                  return 'Name can not be empty';
                                }
                                return null;
                              }
                            },
                            type: TextInputType.text,
                            prefix: Icons.email),
                        SizedBox(
                          height: 20,
                        ),
                        DefaultTextForm(
                            labeltext: 'age',
                            showPassfunc: () {
                              // cubit.changeShowPassword();
                            },
                            isPassword: false,
                            controller: age,
                            validate: (value) {
                              if (value != null) {
                                if (value.isEmpty) {
                                  return 'age required';
                                }
                                return null;
                              }
                            },
                            type: TextInputType.visiblePassword,
                            prefix: Icons.lock),
                        SizedBox(
                          height: 20,
                        ),
                        DefaultTextForm(
                            labeltext: 'birthdate',
                            showPassfunc: () {
                              // cubit.changeShowPassword();
                            },
                            isPassword: false,
                            controller: birthDate,
                            validate: (value) {
                              if (value != null) {
                                if (value.isEmpty) {
                                  return 'birthdate required';
                                }
                                return null;
                              }
                            },
                            type: TextInputType.datetime,
                            onTap: () async {
                              final selectedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );

                              if (selectedDate != null) {
                                //  birthDate.text = selectedDate.toString();
                                String formattedDate = DateFormat('yyyy-MM-dd')
                                    .format(selectedDate);

                                // تحديث حقل النص بالتاريخ المحول
                                birthDate.text = formattedDate;
                                print(formattedDate.toString());
                              }
                            },
                            prefix: Icons.lock),
                        SizedBox(
                          height: 30,
                        ),
                        CountryPickerDropdown(
                          isExpanded: true,
                          initialValue: 'EG',
                          itemBuilder: (Country country) {
                            return Row(
                              children: <Widget>[
                                CountryPickerUtils.getDefaultFlagImage(country),
                                SizedBox(width: 8.0),
                                Expanded(
                                  child: Text(
                                    country.name,
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                )
                              ],
                            );
                          },
                          onValuePicked: (Country? country) {
                            nationalityID.text = country?.isoCode as String;
                            print(country?.isoCode);
                            //  print(selectedCountry!.isoCode);
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Conditional.single(
                            context: context,
                            conditionBuilder: (context) => true,
                            widgetBuilder: (context) => DefaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  SqliteCubit.get(context).insertDataToDatabase(
                                    birthday: birthDate.text,
                                    name: name.text,
                                    age: age.text,
                                    nationalityID: nationalityID.text,
                                  );
                                }
                              },
                              text: 'Save',
                              isUperCase: true,
                              radius: 15,
                            ),
                            fallbackBuilder: (context) => Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
