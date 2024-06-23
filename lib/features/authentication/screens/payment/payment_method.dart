import 'package:cf_sarasavi_app/features/authentication/screens/payment/widgets/payment_method_tile.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../bank_deposit/bank_deposit.dart';
import '../card_payment/card_payment.dart';
import '../physical_payment/physical_payment.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },

      child: Scaffold(
        appBar: AppBar(
          title: /// Title
          Text(
            TTexts.paymentMethod,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                /// Image
                Image(
                  image: const AssetImage(TImages.paymentBanner),
                  width: THelperFunctions.screenWidth() * 0.8,
                ),
                const SizedBox(height: TSizes.spaceBtwSections),

                /// Card Payment
                PaymentMethodTile(
                  screen: () => const CardPayment(),
                  icon: Iconsax.card,
                  text: TTexts.cardPayment,
                ),
                const SizedBox(height: TSizes.spaceBtwSections),

                /// Bank Deposit
                PaymentMethodTile(
                  screen: () => const BankDeposit(),
                  icon: Iconsax.bank,
                  text: TTexts.bankDeposit,
                ),
                const SizedBox(height: TSizes.spaceBtwSections),

                /// Physical Payment
                PaymentMethodTile(
                  screen: () => const PhysicalPaymentScreen(),
                  icon: Iconsax.building,
                  text: TTexts.physicalPayment,
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
