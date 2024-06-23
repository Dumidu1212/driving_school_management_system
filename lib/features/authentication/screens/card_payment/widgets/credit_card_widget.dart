import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';

class PaymentCreditCardWidget extends StatelessWidget {
  const PaymentCreditCardWidget({
    super.key,
    required this.cardNumber,
    required this.expiryDate,
    required this.cardHolderName,
    required this.cvvCode,
    required this.showBackView,
  });

  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cvvCode;
  final bool showBackView;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          double cardWidth = constraints.maxWidth * 0.8;

          if (MediaQuery.of(context).orientation == Orientation.landscape) {
            cardWidth = constraints.maxWidth * 0.5;
          }

          return SizedBox(
            width: cardWidth,
            child: CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: showBackView,
              labelCardHolder: 'CARD HOLDER',
              isHolderNameVisible: true,
              backgroundImage: TImages.cardBackground,
              onCreditCardWidgetChange: (brand) {},
              enableFloatingCard: true,
              obscureCardNumber: true,
              obscureInitialCardNumber: false,
              obscureCardCvv: true,
              floatingConfig: const FloatingConfig(
                isGlareEnabled: true,
                isShadowEnabled: true,
                shadowConfig: FloatingShadowConfig(),
              ),
              animationDuration: const Duration(milliseconds: 1000),
              labelValidThru: 'VALID\nTHRU',
              chipColor: TColors.gold,
            ),
          );
        },
      ),
    );
  }
}
