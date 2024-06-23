import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class HomeNavigationTile extends StatelessWidget {
  const HomeNavigationTile({
    super.key,
    required this.image,
    required this.title,
    this.onTap,
  });

  final String image, title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: THelperFunctions.screenWidth() * 0.18,
            decoration: BoxDecoration(
                color: (dark ? TColors.white.withOpacity(0.2) : TColors.black.withOpacity(0.1)),
                borderRadius: BorderRadius.circular(THelperFunctions.screenWidth() * 0.15/ 3)
            ),
            padding: const EdgeInsets.all(TSizes.sm),
            child: Image(image: AssetImage(image), fit: BoxFit.cover),
          ),
          const SizedBox(height: TSizes.sm / 2),
          SizedBox(
            width: THelperFunctions.screenWidth() * 0.2,
            child: Center(
              child: Text(
                title,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: (dark ? TColors.white : TColors.black),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),


            ),
          ),
        ],
      ),
    );
  }
}

