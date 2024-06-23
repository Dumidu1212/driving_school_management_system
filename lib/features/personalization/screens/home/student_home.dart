import 'package:cf_sarasavi_app/features/personalization/controllers/documents_controller.dart';
import 'package:cf_sarasavi_app/features/personalization/screens/home/widgets/home_appbar.dart';
import 'package:cf_sarasavi_app/features/personalization/screens/home/widgets/home_indication_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/image_text_widgets/home_navigation_tile.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../authentication/screens/payment/payment_method.dart';

class StudentHomeScreen extends StatelessWidget {
  const StudentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(DocumentsController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header
            const PrimaryHeaderContainer(
              child: Column(
                children: [
                  /// AppBar
                  HomeAppBar(),
                  SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),

            /// Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),

              /// Homepage Navigation Buttons
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      HomeNavigationTile(
                          image: TImages.paymentIcon,
                          title: TTexts.payments,
                          onTap: () {}),
                      HomeNavigationTile(
                          image: TImages.mapIcon,
                          title: TTexts.map,
                          onTap: () {}),
                      HomeNavigationTile(
                          image: TImages.documentIcon,
                          title: TTexts.documents,
                          onTap: () {}),
                      HomeNavigationTile(
                          image: TImages.videoIcon,
                          title: TTexts.tutorial,
                          onTap: () {}),
                    ],
                  ),

                  const SizedBox(height: TSizes.spaceBtwSections * 1),
                  /// Divider
                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwSections / 2),

                  ///  Payments Section
                  const SectionHeading(title: TTexts.payments),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Container(
                    width: THelperFunctions.screenWidth(),
                    decoration: BoxDecoration(
                      color: dark ? Colors.black54 : TColors.grey.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(
                          THelperFunctions.screenHeight() * 0.02),
                    ),
                    child: Column(
                      children: [
                        HomeIndicationContainer(
                            icon: const Icon(Icons.payment_rounded),
                            title: TTexts.payedRegistrationFee,
                            backgroundColor: TColors.accent,
                            buttonTitle: TTexts.payed,
                            price: TTexts.registrationPayment,
                            onTap: () => Get.to(() => const PaymentMethod()),
                        ),
                        HomeIndicationContainer(
                          icon: const Icon(Icons.payment_rounded),
                          title: TTexts.firstPayment,
                          price: TTexts.firstPaymentPrice,
                          buttonTitle: TTexts.pay,
                          onTap: () => Get.to(() => const PaymentMethod()),
                        ),
                        HomeIndicationContainer(
                          icon: const Icon(Icons.payment_rounded),
                          title: TTexts.secondPayment,
                          price: TTexts.secondPaymentPrice,
                          buttonTitle: TTexts.pay,
                          onTap: () => Get.to(() => const PaymentMethod()),
                        ),
                        HomeIndicationContainer(
                          icon: const Icon(Icons.payment_rounded),
                          title: TTexts.thirdPayment,
                          price: TTexts.thirdPaymentPrice,
                          buttonTitle: TTexts.pay,
                          onTap: () => Get.to(() => const PaymentMethod()),
                        ),
                        const SizedBox(height: TSizes.md),
                      ],
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// Divider
                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwSections / 2),

                  ///  Documents Section
                  const SectionHeading(title: TTexts.documents),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Container(
                    width: THelperFunctions.screenWidth(),
                    decoration: BoxDecoration(
                      color: dark ? Colors.black54 : TColors.grey.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(
                          THelperFunctions.screenHeight() * 0.02),
                    ),
                    child: Column(
                      children: [
                        HomeIndicationContainer(
                          icon: const Icon(Iconsax.document),
                          title: TTexts.medical,
                          backgroundColor: TColors.accent,
                          buttonTitle: TTexts.done,
                          onTap: () => controller.uploadUserDocuments('medical'),
                        ),
                        HomeIndicationContainer(
                          icon: const Icon(Iconsax.document),
                          title: TTexts.birthCertificate,
                          buttonTitle: TTexts.upload,
                          onTap: () => controller.uploadUserDocuments('birthCertificate'),
                        ),
                        HomeIndicationContainer(
                          icon: const Icon(Iconsax.document),
                          title: TTexts.identityCard,
                          buttonTitle: TTexts.upload,
                          onTap: () => controller.uploadUserDocuments('identityCard'),
                        ),
                        HomeIndicationContainer(
                          icon: const Icon(Iconsax.document),
                          title: TTexts.drivingLicense,
                          buttonTitle: TTexts.upload,
                          onTap: () => controller.uploadUserDocuments('drivingLicense'),
                        ),
                        const SizedBox(height: TSizes.md),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
