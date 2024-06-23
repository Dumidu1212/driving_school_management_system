import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class PhysicalPaymentBody extends StatelessWidget {
  const PhysicalPaymentBody({
    super.key,
    required this.image,
    required this.title,
  });

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          width: THelperFunctions.screenWidth() * 0.7,
          image: AssetImage(image),
        ),

        const SizedBox(height: TSizes.appBarHeight),

        Text(title,
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center),
        const SizedBox(height: TSizes.spaceBtwItems),

      ],
    );
  }
}