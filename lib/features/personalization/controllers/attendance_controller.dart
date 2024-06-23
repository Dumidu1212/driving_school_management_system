import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../data/repositories/attendance/attendance_repository.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/popups/loaders.dart';
import '../models/attendance_model.dart';

class AttendanceController extends GetxController {
  static AttendanceController get instance => Get.find();

  final isLoading = false.obs;
  final _attendanceRepository = Get.put(AttendanceRepository());
  RxList<AttendanceModel> allAttendanceDetails = <AttendanceModel>[].obs;
  RxList<AttendanceModel> featuredAttendance = <AttendanceModel>[].obs;

  @override
  void onInit() {
    fetchAttendance();
    super.onInit();
  }

  /// --- Load Attendance Data
  Future<void> fetchAttendance() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw Exception(TTexts.userNotLoggedIn);
      }

      // Show loader while loading attendance details
      isLoading.value = true;

      // Fetch attendance details from data source (Firestore, API, etc.)
      final attendanceDetails = await _attendanceRepository.getAllAttendanceDetailsForCurrentStudent();

      // Update the attendance list
      allAttendanceDetails.assignAll(attendanceDetails);

      // Filter Featured attendance
      featuredAttendance.assignAll(allAttendanceDetails.where((attendance) => attendance.studentID == currentUser.uid).toList());
    } catch (e) {
      TLoaders.errorSnackBar(title: TTexts.error, message: e.toString());
    } finally {
      // Remove Loader
      isLoading.value = false;
    }
  }

/// --- Load Selected Attendance Data
}
