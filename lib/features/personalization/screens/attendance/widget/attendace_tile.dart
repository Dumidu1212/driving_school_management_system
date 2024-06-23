import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class AttendanceTile extends StatelessWidget {
  const AttendanceTile({
    super.key,
    this.icon = Iconsax.close_circle,
    required this.title,
    this.subTitle,
    this.onTap,
    this.color = TColors.secondary,
    this.date,
  });

  final IconData icon;
  final String title;
  final String? date;
  final String? subTitle;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.only(left: TSizes.defaultSpace, right: TSizes.defaultSpace, bottom: TSizes.spaceBtwItems, top: TSizes.sm /2),
      child: Container(
        decoration: BoxDecoration(
          color: dark ? TColors.black.withOpacity(0.4) : TColors.white,
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
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          leading: Icon(icon, size: 28, color: color),
          title: Text(title, style: Theme.of(context).textTheme.titleMedium),
          subtitle: subTitle != null ? Text(subTitle!, style: Theme.of(context).textTheme.labelMedium) : null,
          trailing: date != null ? Text(date!, style: Theme.of(context).textTheme.labelLarge) : null,
          onTap: onTap,
        ),
      ),
    );
  }
}
