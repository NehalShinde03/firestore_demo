import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_demo/data_base_helper/data_base_helper.dart';
import 'package:firestore_demo/model_class/data_model.dart';
import 'package:firestore_demo/view/add_data/add_data_view.dart';
import 'package:firestore_demo/view/home/home_cubit.dart';
import 'package:firestore_demo/view/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const String routeName = 'home_view';

  static Widget builder(BuildContext context) => BlocProvider(
        create: (context) => HomeCubit(HomeState()),
        child: const HomeView(),
      );

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
      appBar: AppBar(
        title: const Text('Show Data'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddDataView.routeName,);
        },
        child: const Icon(Icons.add),
      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("student").snapshots(),
        builder: (BuildContext context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if(snapshot.connectionState == ConnectionState.none){
            return throw Exception('e1');
          }
          else if (snapshot.data == null) {
            return const Center(child: Text('Data Not Available...!!!!'));
          } else {
            return ListView.separated(
              itemCount: snapshot.data?.docs.length??0,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding:
                  const EdgeInsetsDirectional.symmetric(horizontal: 7, vertical: 5),
                  child: Card(
                    color: Colors.blueGrey,
                    elevation: 10,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Delete...!!!!'),
                              content:
                              const Text('are you sure to delete selected file.....'),
                              actions: [
                                TextButton(
                                  onPressed: (){
                                    DataBaseHelper().deleteData(key: snapshot.data?.docs[index].id??"");
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Delete'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsetsDirectional.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('enrollment number = ${snapshot.data?.docs[index]["enrollmentNumber"]}',
                                style: const TextStyle(
                                    color: Colors.white, fontWeight: FontWeight.bold)),
                            Text('name = ${snapshot.data?.docs[index]["name"]}',
                                style: const TextStyle(
                                    color: Colors.white, fontWeight: FontWeight.bold)),
                            Text('department = ${snapshot.data?.docs[index]["department"]}',
                                style: const TextStyle(
                                    color: Colors.white, fontWeight: FontWeight.bold)),
                            Text('semester = ${snapshot.data?.docs[index]["semester"]}',
                                style: const TextStyle(
                                    color: Colors.white, fontWeight: FontWeight.bold)),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                onPressed: () {

                                  Navigator.pushNamed(
                                      context,
                                      AddDataView.routeName,
                                      arguments: snapshot.data?.docs[index],
                                  );
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Gap(2);
              },
            );
          }
        },
      ),
    ));
  }

  // Widget displayData(data) {
  //   print('data -----------> $data');
  //   return
  // }
}
