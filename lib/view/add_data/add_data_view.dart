import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_demo/data_base_helper/data_base_helper.dart';
import 'package:firestore_demo/model_class/data_model.dart';
import 'package:firestore_demo/view/add_data/add_data_cubit.dart';
import 'package:firestore_demo/view/add_data/add_data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddDataView extends StatefulWidget {
  const AddDataView({super.key,});

  static const String routeName = "add_data_view";

  static Widget builder(BuildContext context){
    print('runtype ===? ${ModalRoute.of(context)?.settings.arguments.runtimeType}');
    final args = ModalRoute.of(context)?.settings.arguments as QueryDocumentSnapshot<Map<String,dynamic>>?;

    return BlocProvider(
      create: (context) => AddDataCubit(
        AddDataState(
            enrollmentNumberController: TextEditingController(text: '${args?.get('enrollmentNumber')}'),
            nameController: TextEditingController(text: args?.get('name')),
            semesterController: TextEditingController(text: args?.get('semester').toString()),
            departmentController: TextEditingController(text: args?.get('department')),
            argument: args
        ),
      ),
      child: const AddDataView(),
    );
  }

  @override
  State<AddDataView> createState() => _AddDataViewState();
}

class _AddDataViewState extends State<AddDataView> {

  final db = DataBaseHelper();
  final GlobalKey<FormState> _formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddDataCubit, AddDataState>(
  builder: (context, state) {
    print('argument ==> ${state.argument.toString().isEmpty}');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(state.argument == null ? 'Add Data' : 'Update Data'),
        ),
        body: BlocBuilder<AddDataCubit, AddDataState>(
          builder: (context, state) {
            return Form(
              key: _formkey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.all(15),
                    child: TextFormField(
                      controller: state.enrollmentNumberController,
                      enabled: state.argument == null ? true : false,
                      validator: (val){
                        if(val!.isEmpty){
                          return 'field requried';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'enter enrollment number'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.all(15),
                    child: TextFormField(
                      controller: state.nameController,
                      validator: (val){
                        if(val!.isEmpty){
                          return 'field requried';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'enter name'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.all(15),
                    child: TextFormField(
                      controller: state.departmentController,
                      validator: (val){
                        if(val!.isEmpty){
                          return 'field requried';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'enter department'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.all(15),
                    child: TextFormField(
                      controller: state.semesterController,
                      validator: (val){
                        if(val!.isEmpty){
                          return 'field requried';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'enter semester'),
                    ),
                  ),
                  ///insert data
                  MaterialButton(
                      color: Colors.teal,
                      onPressed: () {
                        print('update key====> ${state.argument?.id}');
                        if(_formkey.currentState!.validate()){
                          if(state.argument == null){
                            DataBaseHelper().addData(studentDataModel: StudentDataModel(
                                enrollmentNumber: int.parse(state.enrollmentNumberController.text),
                                name: state.nameController.text.toString(),
                                semester: int.parse(state.semesterController.text),
                                department:state.departmentController.text.toString(),
                                creationDate: DateFormat('dd-mm-yyyy').format(DateTime.now())
                            ));
                          }
                          else{
                            print('iidddd--> ${state.argument?.id}');
                            DataBaseHelper().updateData(
                             key: state.argument?.id,
                             studentModel: StudentDataModel(
                                enrollmentNumber: int.parse(state.enrollmentNumberController.text.toString()),
                                name: state.nameController.text.toString(),
                                semester: int.parse(state.semesterController.text.toString()),
                                department: state.departmentController.text.toString(),
                                creationDate: DateFormat('dd-mm-yyyy').format(DateTime.now()).toString()
                            ));
                          }
                          Navigator.pop(context);
                        }
                        // context.read<AddDataCubit>().onTap(context);
                      },
                      child: Text(state.argument == null ? 'Add' : 'Update',style: const TextStyle(color: Colors.white),))
                ],
              ),
            );
          },
        ),
      ),
    );
  },
);
  }
}


/*                    onPressed: () {
                      db.addUser(
                        studentDataModel: StudentDataModel(
                            enrollmentNumber: int.parse(state.enrollmentNumberController.text.toString()),
                            name: state.nameController.text.toString(),
                            semester: int.parse(state.semesterController.text.toString()),
                            department:state.departmentController.text.toString(),
                            creationDate: DateFormat('dd-mm-yyyy ').format(DateTime.now())),
                      ).whenComplete(() {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.blueGrey,
                          content: const Text('Data Inserted in FireStore..!!!',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                          dismissDirection: DismissDirection.up,
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {},
                          ),
                        ));
                        Navigator.pop(context);
                      });
                    }*/

/* ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.blueGrey,
          content: const Text('Data Inserted in FireStore..!!!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
          dismissDirection: DismissDirection.up,
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {},
          ),
        ));
        Navigator.pop(context);*/