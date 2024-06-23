import 'package:cf_sarasavi_app/features/personalization/screens/attendance/widget/attendace_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/shimmers/attendance_shimmer.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/attendance_controller.dart';

class StudentAttendance extends StatelessWidget {
  const StudentAttendance({super.key});

  Future<void> _onRefresh() async {
    final attendanceController = Get.find<AttendanceController>();
    await attendanceController.fetchAttendance();
  }

  @override
  Widget build(BuildContext context) {
    final attendanceController = Get.put(AttendanceController());
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(), // Ensure scroll physics are always active
          child: Column(
            children: [
              PrimaryHeaderContainer(
                child: Column(
                  children: [
                    TAppBar(
                      title: Text(
                        TTexts.attendance,
                        style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.white),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),
                  ],
                ),
              ),

              /// Body
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// Title
                  const Padding(
                    padding: EdgeInsets.all(TSizes.defaultSpace),
                    child: SectionHeading(title: TTexts.trainingSessions),
                  ),

                  /// Attendance tiles
                  Obx(() {
                    if (attendanceController.isLoading.value) return const AttendanceShimmer();

                    if (attendanceController.allAttendanceDetails.isEmpty) {
                      return Center(child: Text(TTexts.noDataFound, style: Theme.of(context).textTheme.bodyMedium!.apply(color: dark ? TColors.white : TColors.black)));
                    }
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: attendanceController.allAttendanceDetails.length,
                      itemBuilder: (_, index) {
                        final attendance = attendanceController.allAttendanceDetails[index];
                        return AttendanceTile(
                          icon: Iconsax.car,
                          date: attendance.date,
                          title: 'Day ${attendance.day}',
                          subTitle: 'Instructor Mr: ${attendance.instructor}',
                        );
                      },
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
