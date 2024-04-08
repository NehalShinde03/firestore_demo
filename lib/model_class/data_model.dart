import 'package:cloud_firestore/cloud_firestore.dart';

class StudentDataModel {

  final int enrollmentNumber;
  final String name;
  final String department;
  final int semester;
  final String creationDate;

  StudentDataModel({
    this.enrollmentNumber=0,
    this.name="",
    this.department="",
    this.creationDate="",
    this.semester=0,
  });

  factory StudentDataModel.fromJson(Map<String, dynamic> json){
    return StudentDataModel(
        enrollmentNumber: json['enrollmentNumber'],
        name: json['name'],
        department: json['department'],
        semester: json['semester'],
        creationDate: json['creationDate']);
  }

  Map<String, dynamic> toJson() => {
        'enrollmentNumber': enrollmentNumber,
        'name': name,
        'department': department,
        'semester': semester,
        'creationDate': creationDate
      };
}
