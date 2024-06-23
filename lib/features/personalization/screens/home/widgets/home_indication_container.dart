import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class HomeIndicationContainer extends StatelessWidget {
  const HomeIndicationContainer({
    super.key,
    required this.icon,
    required this.title,
    required this.buttonTitle,
    this.price = '',
    required this.onTap,
    this.backgroundColor = TColors.red,
  });

  final Icon icon;
  final String title;
  final String buttonTitle;
  final Color? backgroundColor;
  final String? price;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: TSizes.md, left: TSizes.md, right: TSizes.md),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            decoration: BoxDecoration(
              color: backgroundColor?.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              leading: icon,
              title: Text(
                '$title $price',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              trailing: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: backgroundColor,
                  side: const BorderSide(color: Colors.transparent),
                ),
                onPressed: onTap,
                child: Text(
                  buttonTitle,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}