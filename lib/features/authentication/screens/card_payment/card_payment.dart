import 'package:cf_sarasavi_app/features/authentication/screens/card_payment/widgets/credit_card_form.dart';
import 'package:cf_sarasavi_app/features/authentication/screens/card_payment/widgets/credit_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/success_screen/success_screen.dart';
import '../../../../navigation_menu.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';

class CardPayment extends StatefulWidget {
  const CardPayment({super.key});

  @override
  State<CardPayment> createState() => _CardPaymentState();
}

class _CardPaymentState extends State<CardPayment> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool showBackView = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> onCreditCard(CreditCardModel creditCard) async {
    setState(() {
      cardNumber = creditCard.cardNumber;
      expiryDate = creditCard.expiryDate;
      cardHolderName = creditCard.cardHolderName;
      cvvCode = creditCard.cvvCode;
      showBackView = creditCard.isCvvFocused;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          TTexts.paymentMethod,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: OrientationBuilder(
          builder: (context, orientation) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  /// Card UI Widget
                  PaymentCreditCardWidget(
                    cardNumber: cardNumber,
                    expiryDate: expiryDate,
                    cardHolderName: cardHolderName,
                    cvvCode: cvvCode,
                    showBackView: showBackView,
                  ),

                  const SizedBox(height: TSizes.spaceBtwItems),

                  /// Card Details Entering Form
                  PaymentsCreditCardForm(
                    onCreditCardModelChange: onCreditCard,
                    formKey: _formKey,
                  ),

                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// Card Details Save Check Box
                  Row(
                    children: [
                      Checkbox(value: true, onChanged: (value) {}),
                      const Text(TTexts.saveThisCard),
                    ],
                  ),

                  const SizedBox(height: TSizes.spaceBtwItems),

                  /// Pay Button
                  ElevatedButton(
                    onPressed: () => Get.offAll(() => SuccessScreen(
                      image: TImages.paymentSuccess,
                      title: TTexts.paymentSuccessful,
                      subTitle: TTexts.initialPayment,
                      onPressed: () => Get.to(() => const NavigationMenu()),
                    )),
                    child: const Text(TTexts.pay),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
