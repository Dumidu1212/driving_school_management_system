import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    this.icon = Iconsax.close_circle,
    required this.title,
    required this.subTitle,
    this.onTap,
    this.color = TColors.primary,
    this.date,
  });

  final IconData icon;
  final String title;
  final String? date;
  final String subTitle;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace / 2),
        child: Container(
          decoration: BoxDecoration(
            color: dark ? TColors.black : TColors.white,
          ),
          child: Slidable(
            endActionPane:  ActionPane(
              motion:  const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {},
                  icon: Icons.delete,
                  backgroundColor: TColors.red,
                ),
              ],
            ),
            child: ListTile(
              leading: Icon(icon, size: 28, color: color),
              title: Text(title,
                  style: Theme.of(context).textTheme.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
              subtitle: Text(subTitle,
                      style: Theme.of(context).textTheme.labelMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
              trailing: date != null
                  ? Text(date!, style: Theme.of(context).textTheme.labelLarge)
                  : null,
              onTap: onTap,
            ),
          ),
        ),
      ),
    );
  }
}
