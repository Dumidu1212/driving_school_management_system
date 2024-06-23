import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/list_tiles/settings_menu_tile.dart';
import '../../../../common/widgets/list_tiles/user_profile_tile.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../data/repositories/repositories.authentication/authentication_repository.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../profile/profile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// --- Header
            PrimaryHeaderContainer(
              child: Column(
                children: [
                  TAppBar(
                      title: Text(TTexts.account, style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.white))),

                  /// User Profile Card
                  UserProfileTile(onPressed: () => Get.to(() => const ProfileScreen())),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),

            /// --- Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  /// -- Account Settings
                  const SectionHeading(title: TTexts.accountSettings),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  
                  SettingsMenuTile(icon: Icons.app_registration, title: TTexts.myRegistrationForm, subTitle: TTexts.editRegistrationForm, onTap: (){}),
                  SettingsMenuTile(icon: Icons.question_mark, title: TTexts.usingSarasaviLearnersMobileApp, subTitle: TTexts.howToUse, onTap: (){}),
                  SettingsMenuTile(icon: Icons.payments, title: TTexts.payments, subTitle: TTexts.paymentOptions, onTap: (){}),
                  SettingsMenuTile(icon: Icons.language, title: TTexts.changeMyLanguage, subTitle: TTexts.languageOptions, onTap: (){}),
                  SettingsMenuTile(icon: Icons.info_rounded, title: TTexts.appIssues, subTitle: TTexts.howToResolve, onTap: (){}),

                  /// -- Logout Button
                  const SizedBox(height: TSizes.spaceBtwSections,),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(onPressed: () => AuthenticationRepository.instance.logout(), child: const Text(TTexts.logOut)),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
