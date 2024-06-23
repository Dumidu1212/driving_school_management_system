import 'package:cf_sarasavi_app/features/personalization/screens/profile/widgets/profile_information.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_shapes/containers/circular_image.dart';
import '../../../../common/widgets/shimmers/shimmer.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../controllers/user_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text(TTexts.profile),
      ),

      /// -- Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final networkImage = controller.user.value.profilePicture;
                      final image = networkImage.isNotEmpty ? networkImage : TImages.user;
                      return controller.imageUploading.value
                          ? const TShimmerEffect(width: 80, height: 80)
                          : CircularImage(image: image, width: 80, height: 80, padding: 0, isNetworkImage: networkImage.isNotEmpty);
                    }),
                    TextButton(onPressed: () => controller.uploadUserProfilePicture(), child: const Text(TTexts.changeProfilePicture)),
                  ],
                ),
              ),

              /// Details
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              const SectionHeading(title: TTexts.profileInformation),
              const SizedBox(height: TSizes.spaceBtwItems),

              ProfileInformation(title: TTexts.studentId, value: controller.user.value.id, icon: Iconsax.copy,),
              ProfileInformation(title: TTexts.name, value: controller.user.value.nameWithInitials),
              ProfileInformation(title: TTexts.email, value: controller.user.value.email),

              const SizedBox(height: TSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              const SectionHeading(title: TTexts.personalInformation),
              const SizedBox(height: TSizes.spaceBtwItems),

              ProfileInformation(title: TTexts.dateOfBirth, value: controller.user.value.dateOfBirth),
              ProfileInformation(title: TTexts.gender, value: controller.user.value.gender),
              ProfileInformation(title: TTexts.address, value: controller.user.value.permanentAddress),
              ProfileInformation(title: TTexts.telephone, value: controller.user.value.telephoneNumber),
              ProfileInformation(title: TTexts.nic, value: controller.user.value.nationalIdentityCardNo),

              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              Center(
                child: TextButton(
                  onPressed: () => controller.deleteAccountWarningPopup(),
                  child: const Text(TTexts.closeAccount, style: TextStyle(color: TColors.red)),
                ),
              )

            ],
          ),


        ),


      ),
    );
  }
}


