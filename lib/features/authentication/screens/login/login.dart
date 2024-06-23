import 'package:cf_sarasavi_app/features/authentication/screens/login/widgets/login_form.dart';
import 'package:cf_sarasavi_app/features/authentication/screens/login/widgets/login_header.dart';
import 'package:flutter/material.dart';
import '../../../../common/styles/spacing_styles.dart';
import '../../../../common/widgets/development_company_signature/development_company_signature.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: TSpacingStyles.paddingWithAppBarHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  children: [
                    /// Login Header
                    TLoginHeader(),

                    /// Login Form
                    TLoginForm(),

                    SizedBox(height: TSizes.spaceBtwSections),
                  ],
                ),

                /// CircuitForge Signature
                DevelopmentCompanySignature(dark: dark),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

