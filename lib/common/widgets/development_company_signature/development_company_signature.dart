import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/text_strings.dart';

class DevelopmentCompanySignature extends StatelessWidget {
  const DevelopmentCompanySignature({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text.rich(
          TextSpan(children: [
            TextSpan(
              text: '${TTexts.poweredBy} ',
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                color: dark ? TColors.white : TColors.black,
                decorationColor: dark ? TColors.white : TColors.black,
              ),
            ),
            TextSpan(
              text: TTexts.circuit,
              style: Theme.of(context).textTheme.titleMedium!.apply(
                color: dark ? TColors.white : TColors.black,
                decorationColor: dark ? TColors.white : TColors.black,
              ),
            ),
            TextSpan(
              text: TTexts.forge,
              style: Theme.of(context).textTheme.titleMedium!.apply(
                color: Colors.blueAccent,
              ),
            ),
            /// Registered Symbol
            TextSpan(
              text: TTexts.registered,
              style: Theme.of(context).textTheme.titleMedium!.apply(
                color: dark ? TColors.white : TColors.black,
                decorationColor: dark ? TColors.white : TColors.black,
              ),
            ),
          ]),
        ),
      ],
    );
  }
}