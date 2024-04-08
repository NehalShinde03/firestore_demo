import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_demo/model_class/data_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class DataBaseHelper {

  final fireStoreInstance = FirebaseFirestore.instance;

  ///insert
 void addData({required StudentDataModel studentDataModel}) async {
   fireStoreInstance.collection('student').add(studentDataModel.toJson());
 }

  // ///read
  // Stream<List<StudentDataModel>> readData() {
  //   try{
  //     return fireStoreInstance
  //         .collection('student')
  //         .snapshots()
  //         .map((snapshotData) => snapshotData.docs.map((doc) => StudentDataModel.fromJson(doc.data())).toList());
  //   }catch(e){
  //     return throw Exception('read data exception ===> $e');
  //   }
  //
  // }

  ///update
  Future<void> updateData({required String? key,required StudentDataModel studentModel}) async{
   print('update key ====? $key');
   await fireStoreInstance.collection('student').doc(key).update(studentModel.toJson());
  }

//Unhandled Exception: [cloud_firestore/not-found] Some requested document was not found.

  ///delete
  Future<void> deleteData({required String key}) async{
    await fireStoreInstance.collection('student').doc(key).delete();
  }


}