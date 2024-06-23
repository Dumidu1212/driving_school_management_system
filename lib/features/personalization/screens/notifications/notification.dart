import 'package:cf_sarasavi_app/features/personalization/screens/notifications/widgets/notification_tile.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PrimaryHeaderContainer(
              child: Column(
                children: [
                  TAppBar(
                    title: Text(
                      TTexts.notifications,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: TColors.white),
                    ),
                  ),
                  const SearchContainer(text: TTexts.searchNotifications),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),

            /// Body
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// Attendance tiles
                ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (_, index) {
                    return NotificationTile(
                      onTap: () {},
                      icon: Iconsax.notification,
                      title: 'Sarasavi Learners',
                      date: '2024/05/02',
                      subTitle: 'Hi, Welcome to Sarasavi Learners driving school.',
                    );
                  }, separatorBuilder: (_, index) => const Divider(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
