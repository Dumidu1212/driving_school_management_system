import 'package:cf_sarasavi_app/features/authentication/screens/bank_deposit/widgets/bank_deposit_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/styles/spacing_styles.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';

class BankDeposit extends StatelessWidget {
  const BankDeposit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// Title
        title: Text(
          TTexts.bankDeposit,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: TSpacingStyles.paddingWithAppBarHeight * 2,
            child: Column(
              children: [
                const BankDepositHeader(
                  image: TImages.bankDeposit,
                  title: TTexts.pleaseUploadYourBankPaymentReceipt,
                ),

                const SizedBox(height: TSizes.appBarHeight),

                /// Document Upload Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => Get.to(() => const ()),
                    icon: const Icon(Icons.upload_outlined),
                    label: const Text(TTexts.upload),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
