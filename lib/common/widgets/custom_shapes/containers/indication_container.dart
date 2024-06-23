import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../features/authentication/screens/payment/payment_method.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';

class IndicationContainer extends StatelessWidget {
  const IndicationContainer({
    super.key,
    this.backgroundColor = TColors.red,
    required this.text
  });

  final Color backgroundColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.spaceBtwItems / 2),
      child: Container(
        width: THelperFunctions.screenWidth() * 0.8,
        height: THelperFunctions.screenHeight() * 0.09,
        padding: const EdgeInsets.all(TSizes.sm / 2),
        decoration: BoxDecoration(
          color: backgroundColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              ElevatedButton(
                onPressed: () => Get.to(() => const PaymentMethod()),
                child:  const Text(TTexts.payed),
              ),
            ],
          ),
        ),
      ),
    );
  }
}