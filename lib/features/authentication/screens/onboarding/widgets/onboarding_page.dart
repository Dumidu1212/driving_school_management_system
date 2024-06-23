import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OrientationBuilder(
        builder: (context, orientation) {
          double imageWidth = THelperFunctions.screenWidth() * 0.7;
          double imageHeight = THelperFunctions.screenWidth() * 0.6;

          if (orientation == Orientation.landscape) {
            imageWidth = THelperFunctions.screenWidth() * 0.3;
            imageHeight = THelperFunctions.screenWidth() * 0.2;
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                width: imageWidth,
                height: imageHeight,
                image: AssetImage(image),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(
                subTitle,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
      ),
    );
  }
}
