import 'package:cf_sarasavi_app/features/authentication/screens/physical_payment/widgets/physical_payment_body.dart';
import 'package:flutter/material.dart';
import '../../../../common/styles/spacing_styles.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';


class PhysicalPaymentScreen extends StatelessWidget {
  const PhysicalPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// Title
        title: Text(
          TTexts.physicalPayment,
          style: Theme
              .of(context)
              .textTheme
              .headlineMedium,
        ),
      ),
      body: const SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: TSpacingStyles.paddingWithAppBarHeight ,
            child: Column(
              children: [
                PhysicalPaymentBody(
                  image: TImages.physicalPayment,
                  title: TTexts.pleaseGoToTheNearestSarasaviLearners,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}