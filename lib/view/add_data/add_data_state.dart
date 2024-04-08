import 'package:equatable/equatable.dart';
import 'package:firestore_demo/model_class/data_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddDataState extends Equatable {
  final TextEditingController enrollmentNumberController;
  final TextEditingController nameController;
  final TextEditingController departmentController;
  final TextEditingController semesterController;
  final QueryDocumentSnapshot<Map<String,dynamic>>? argument;

  const AddDataState({
    required this.enrollmentNumberController,
    required this.nameController,
    required this.departmentController,
    required this.semesterController,
    this.argument
  });

  @override
  List<Object?> get props =>
      [enrollmentNumberController, nameController,semesterController,  departmentController, argument];

  AddDataState copyWith(
      {TextEditingController? enrollmentNumberController,
      TextEditingController? nameController,
      TextEditingController? semesterController,
      TextEditingController? departmentController,
        QueryDocumentSnapshot<Map<String,dynamic>>? argument
      }) {
    return AddDataState(
        enrollmentNumberController: enrollmentNumberController ?? this.enrollmentNumberController,
        nameController: nameController ?? this.nameController,
        semesterController: semesterController ?? this.semesterController,
        departmentController: departmentController ?? this.departmentController,
        argument: argument ?? this.argument
    );
  }
}
