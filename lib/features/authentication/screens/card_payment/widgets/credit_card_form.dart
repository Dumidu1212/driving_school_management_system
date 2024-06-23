import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class PaymentsCreditCardForm extends StatelessWidget {
  const PaymentsCreditCardForm({
    super.key,
    required this.formKey,
    required this.onCreditCardModelChange,

  });

  final Function(CreditCardModel) onCreditCardModelChange;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return CreditCardForm(
      onCreditCardModelChange: onCreditCardModelChange,
      cardNumber: '',
      expiryDate: '',
      cardHolderName: '',
      cvvCode: '',
      formKey: formKey,
    );
  }
}