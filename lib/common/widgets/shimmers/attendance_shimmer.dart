import 'package:cf_sarasavi_app/common/widgets/shimmers/shimmer.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class AttendanceShimmer extends StatelessWidget {
  const AttendanceShimmer({
    super.key,
    this.itemCount = 7,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsets.only(left: TSizes.defaultSpace, right: TSizes.defaultSpace, bottom: TSizes.spaceBtwItems, top: TSizes.sm /2),
          child: Container(
            decoration: BoxDecoration(
              color: dark ? TColors.black : TColors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: const ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              leading: TShimmerEffect(width: 55, height: 55, radius: 55),
              title: TShimmerEffect(width: 60, height: 10),
              subtitle: TShimmerEffect(width: 100, height: 8),
              trailing: TShimmerEffect(width: 80, height: 20),
            ),
          ),
        );
      },
    );
  }
}
