import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class PaymentMethodTile extends StatelessWidget {
  const PaymentMethodTile({
    super.key,
    required this.screen,
    required this.icon,
    required this.text,
  });

  final Function() screen;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: TColors.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
      ),
      child: InkWell(
        onTap: () => Get.to(screen()),
        borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: TSizes.appBarHeight,
              horizontal: TSizes.appBarHeight),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon),
              const SizedBox(width: TSizes.spaceBtwItems),
              Text(
                text,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
