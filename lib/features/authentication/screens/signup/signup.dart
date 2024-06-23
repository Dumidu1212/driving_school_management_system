import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/login_signup/form_devider.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/validators/validation.dart';
import '../../controllers/registrationFormController/registration_form_controller.dart';
import '../login/login.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  SignupScreenState createState() => SignupScreenState();
}

final controller = Get.put(RegistrationFormController());

class SignupScreenState extends State<SignupScreen> {
  String? _selectedGender;
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => controller.previousPage(),
            icon: const Icon(Iconsax.arrow_left),
          ),
          title: Text(
            TTexts.register,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        body: Stack(
          children: [
            PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller.pageController,
              onPageChanged: controller.updatePageIndicator,
              children: [
                _buildFormPageOne(),
                _buildDrivingLicenseForm(),
                _buildClassesOfVehiclesForm(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormPageOne() {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              TTexts.signupTitle,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Form(
              key: controller.registrationFormKey1,  // Use global form key
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.nameWithInitials,
                    validator: (value) => TValidator.validateEmptyText(TTexts.nameWithInitials, value),
                    decoration: const InputDecoration(
                      labelText: TTexts.nameWithInitials,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextFormField(
                          validator: (value) => TValidator.validateEmptyText(TTexts.dob, value),
                          readOnly: true,
                          onTap: () => _selectDate(context),
                          controller: controller.dateOfBirth,
                          decoration: const InputDecoration(
                            labelText: TTexts.dateOfBirth,
                            prefixIcon: Icon(Iconsax.calendar),
                          ),
                        ),
                      ),
                      const SizedBox(width: TSizes.spaceBtwInputFields),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          validator: (value) => TValidator.validateEmptyText(TTexts.gender, value),
                          value: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value;
                              controller.gender.text = value!;
                            });
                          },
                          items: [TTexts.male, TTexts.female].map((String gender) {
                            return DropdownMenuItem<String>(
                              value: gender,
                              child: Text(gender),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            labelText: TTexts.gender,
                            prefixIcon: _selectedGender == null
                                ? const Icon(Iconsax.man)
                                : _selectedGender == TTexts.male
                                ? const Icon(Iconsax.man)
                                : const Icon(Iconsax.woman),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  TextFormField(
                    validator: (value) => TValidator.validateEmptyText(TTexts.permanentAddress, value),
                    controller: controller.permanentAddress,
                    decoration: const InputDecoration(
                      labelText: TTexts.permanentAddress,
                      prefixIcon: Icon(Iconsax.home),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  TextFormField(
                    validator: (value) => TValidator.validatePhoneNumber(value),
                    controller: controller.telephoneNumber,
                    decoration: const InputDecoration(
                      labelText: TTexts.telephoneNumber,
                      prefixIcon: Icon(Iconsax.call),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  TextFormField(
                    validator: (value) => TValidator.validateEmptyText(TTexts.nationalIdentityCardNo, value),
                    controller: controller.nationalIdentityCardNo,
                    decoration: const InputDecoration(
                      labelText: TTexts.nationalIdentityCardNo,
                      prefixIcon: Icon(Iconsax.card),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  TextFormField(
                    controller: controller.passportNo,
                    decoration: const InputDecoration(
                      labelText: TTexts.passportNo,
                      prefixIcon: Icon(Iconsax.book),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  TextFormField(
                    validator: (value) => TValidator.validateEmptyText(TTexts.divisionalSecretariat, value),
                    controller: controller.divisionalSecretariat,
                    decoration: const InputDecoration(
                      labelText: TTexts.divisionalSecretariat,
                      prefixIcon: Icon(Iconsax.building),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        if (controller.registrationFormKey1.currentState!.validate()) {
                          controller.nextPage();
                        }
                      },
                      child: const Text(TTexts.next),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrivingLicenseForm() {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              TTexts.haveALicense,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Form(
              key: controller.registrationFormKey2, // Use global form key
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.drivingLicenseNo,
                    decoration: const InputDecoration(
                      labelText: TTexts.drivingLicenseNo,
                      prefixIcon: Icon(Iconsax.card),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  TextFormField(
                    controller: controller.expiredClassOfVehicles,
                    decoration: const InputDecoration(
                      labelText: TTexts.classOfVehicles,
                      prefixIcon: Icon(Iconsax.home),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  TextFormField(
                    readOnly: true,
                    onTap: () => _selectDate(context, isIssueDate: true),
                    controller: controller.drivingLicenseIssuedDate,
                    decoration: const InputDecoration(
                      labelText: TTexts.dateOfIssued,
                      prefixIcon: Icon(Iconsax.calendar),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  TextFormField(
                    readOnly: true,
                    onTap: () => _selectDate(context, isExpiryDate: true),
                    controller: controller.drivingLicenseExpiryDate,
                    decoration: const InputDecoration(
                      labelText: TTexts.dateOfExpiry,
                      prefixIcon: Icon(Iconsax.calendar),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        if (controller.registrationFormKey2.currentState!.validate()) {
                          controller.nextPage();
                        }
                      },
                      child: const Text(TTexts.next),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClassesOfVehiclesForm() {
    final dark = THelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              TTexts.classesOfVehiclesApplying,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Form(
              key: controller.registrationFormKey3, // Use global form key
              child: Column(
                children: [
                  controller.formCheckBox(TTexts.motorBicycle),
                  controller.formCheckBox(TTexts.lightVehicles),
                  controller.formCheckBox(TTexts.threeWheeler),
                  controller.formCheckBox(TTexts.heavyDutyVehicles),
                  controller.formCheckBox(TTexts.primaryMover),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  TextFormField(
                    validator: (value) => TValidator.validateEmail(value),
                    controller: controller.email,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.direct_right),
                      labelText: TTexts.email,
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  Obx(
                    () => TextFormField(
                      validator: (value) => TValidator.validatePassword(value),
                      controller: controller.password,
                      obscureText: controller.hidePassword.value,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Iconsax.password_check),
                        labelText: TTexts.password,
                        suffixIcon: IconButton(
                          onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                          icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  Obx(
                    () => TextFormField(
                      validator: (value) => TValidator.validateEmptyText(TTexts.confirmPassword, value),
                      controller: controller.confirmPassword,
                      obscureText: controller.hidePassword.value,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Iconsax.password_check),
                        labelText: TTexts.confirmPassword,
                        suffixIcon: IconButton(
                          onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                          icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Row(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Obx(
                          () => Checkbox(
                            value: controller.privacyPolicy.value,
                            onChanged: (value) => controller.privacyPolicy.value = !controller.privacyPolicy.value,
                          ),
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${TTexts.iAgreeTo} ',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            TextSpan(
                              text: '${TTexts.privacyPolicy} ',
                              style: Theme.of(context).textTheme.bodyMedium!.apply(
                                color: dark ? TColors.white : TColors.primary,
                                decoration: TextDecoration.underline,
                                decorationColor: dark ? TColors.white : TColors.primary,
                              ),
                            ),
                            TextSpan(
                              text: '${TTexts.and} ',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            TextSpan(
                              text: '${TTexts.termsOfUse} ',
                              style: Theme.of(context).textTheme.bodyMedium!.apply(
                                color: dark ? TColors.white : TColors.primary,
                                decoration: TextDecoration.underline,
                                decorationColor: dark ? TColors.white : TColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (controller.registrationFormKey3.currentState!.validate()) {
                          controller.register();
                        }
                      },
                      child: const Text(TTexts.register),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  const TFormDivider(dividerText: TTexts.registrationFee),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const TFormDivider(dividerText: TTexts.orIfYouHaveAnAccount),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        controller.clearForm();
                        Get.offAll(const LoginScreen());
                      },
                      child: const Text(TTexts.signIn),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, {bool isIssueDate = false, bool isExpiryDate = false}) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      setState(() {
        _selectedDate = selectedDate;
        final dateText = '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}';
        if (isIssueDate) {
          controller.drivingLicenseIssuedDate.text = dateText;
        } else if (isExpiryDate) {
          controller.drivingLicenseExpiryDate.text = dateText;
        } else {
          controller.dateOfBirth.text = dateText;
        }
      });
    } else {
      setState(() {
        _selectedDate = null;
        if (isIssueDate) {
          controller.drivingLicenseIssuedDate.clear();
        } else if (isExpiryDate) {
          controller.drivingLicenseExpiryDate.clear();
        } else {
          controller.dateOfBirth.clear();
        }
      });
    }
  }
}
