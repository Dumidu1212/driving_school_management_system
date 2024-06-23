import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceModel {
  final String id;
  final String studentID;
  String date;
  String instructor;
  String day;

  AttendanceModel({
    required this.id,
    required this.studentID,
    required this.date,
    required this.instructor,
    required this.day,
  });

  // Factory constructor to create an empty instance
  static AttendanceModel empty() => AttendanceModel(
    id: '',
    studentID: '',
    date: '',
    instructor: '',
    day: '',
  );

  // Convert a Firestore document to an AttendanceModel to use in the mobile application
  factory AttendanceModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      return AttendanceModel(
        id: document.id,
        studentID: data['studentID'] ?? '',
        date: data['date'] ?? '',
        instructor: data['instructor'] ?? '',
        day: data['day'] ?? '',
      );
    } else {
      return AttendanceModel.empty();
    }
  }


  // Format the timestamp to a readable date and time string
  // String getFormattedDate() {
  //   DateTime dateTime = date.toDate();
  //   return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
  // }

}
