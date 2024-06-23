import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../features/personalization/models/attendance_model.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class AttendanceRepository extends GetxController {
  static AttendanceRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;

  /// Get all attendance details for the current student
  Future<List<AttendanceModel>> getAllAttendanceDetailsForCurrentStudent() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw TTexts.userNotLoggedIn; // Handle the case where the user is not logged in
      }

      final snapshot = await _db.collection('Attendance').where('studentID', isEqualTo: currentUser.uid).get();

      final list = snapshot.docs.map((document) => AttendanceModel.fromSnapshot(document)).toList();
      return list;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw TTexts.somethingWentWrong;
    }
  }
}
