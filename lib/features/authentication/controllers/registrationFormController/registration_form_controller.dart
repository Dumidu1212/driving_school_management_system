import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/loaders/loaders.dart';
import '../../../../data/repositories/repositories.authentication/authentication_repository.dart';
import '../../../../data/repositories/user/user_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../personalization/models/user_model.dart';
import '../../screens/login/login.dart';
import '../../screens/signup/widgets/verify_email.dart';

class RegistrationFormController extends GetxController {
  static RegistrationFormController get instance => Get.find();

  // Form Fields
  final nameWithInitials = TextEditingController();
  final gender = TextEditingController();
  final dateOfBirth = TextEditingController();
  final permanentAddress = TextEditingController();
  final telephoneNumber = TextEditingController();
  final nationalIdentityCardNo = TextEditingController();
  final passportNo = TextEditingController();
  final divisionalSecretariat = TextEditingController();
  final drivingLicenseNo = TextEditingController();
  final drivingLicenseIssuedDate = TextEditingController();
  final drivingLicenseExpiryDate = TextEditingController();
  final expiredClassOfVehicles = TextEditingController();
  final classOfVehiclesApplying = <String>[].obs; // Observable for vehicle classes
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  // Observable Fields
  final hidePassword = true.obs;
  final privacyPolicy = false.obs;

  // Form Key
  final registrationFormKey1 = GlobalKey<FormState>();
  final registrationFormKey2 = GlobalKey<FormState>();
  final registrationFormKey3 = GlobalKey<FormState>();

  // Page Controller
  final pageController = PageController();
  final currentPageIndex = 0.obs;

  void updatePageIndicator(index) => currentPageIndex.value = index;

  // Track validation status for each page
  final Map<int, bool> validationStatus = {
    0: true, // Page 0 needs validation
    1: false, // Page 1 does not need validation
    2: true, // Page 2 needs validation
  };

  void nextPage() {
    bool needsValidation = validationStatus[currentPageIndex.value] ?? false;
    if (needsValidation) {
      if (registrationFormKey1.currentState!.validate() || registrationFormKey2.currentState!.validate() || registrationFormKey3.currentState!.validate()) {
        pageController.jumpToPage(currentPageIndex.value + 1);
      }
    } else {
      pageController.jumpToPage(currentPageIndex.value + 1);
    }
  }

  void previousPage() {
    if (currentPageIndex.value > 0) {
      pageController.jumpToPage(currentPageIndex.value - 1);
    } else {
      Get.offAll(const LoginScreen());
      clearForm();
    }
  }

  Obx formCheckBox(String vehicleClass) {
    return Obx(
      () => CheckboxListTile(
        title: Text(vehicleClass),
        value: classOfVehiclesApplying.contains(vehicleClass),
        onChanged: (bool? value) {
          if (value == true) {
            classOfVehiclesApplying.add(vehicleClass);
          } else {
            classOfVehiclesApplying.remove(vehicleClass);
          }
        },
      ),
    );
  }

  bool isAtLeastOneClassSelected() {
    return classOfVehiclesApplying.isNotEmpty;
  }

  void clearForm() {
    nameWithInitials.clear();
    gender.clear();
    dateOfBirth.clear();
    permanentAddress.clear();
    telephoneNumber.clear();
    nationalIdentityCardNo.clear();
    passportNo.clear();
    divisionalSecretariat.clear();
    drivingLicenseNo.clear();
    drivingLicenseIssuedDate.clear();
    drivingLicenseExpiryDate.clear();
    expiredClassOfVehicles.clear();
    classOfVehiclesApplying.clear();
    email.clear();
    password.clear();
    confirmPassword.clear();
    hidePassword.value = true;
    privacyPolicy.value = false;
    currentPageIndex.value = 0;
  }

  Future<void> register() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog(TTexts.processingInformation, TImages.processingAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove Loader
        FullScreenLoader.stopLoading();
        return;
      }

      // Password Check
      if (password.text != confirmPassword.text) {
        Loaders.errorSnackBar(
            title: TTexts.error,
            message: TTexts.passwordDoNotMatch
        );

        FullScreenLoader.stopLoading();
        return;
      }

      // Vehicle Classes Validation
      if(!isAtLeastOneClassSelected()) {
        Loaders.errorSnackBar(
            title: TTexts.error,
            message: TTexts.vehicleClassesAreRequired
        );

        FullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!registrationFormKey3.currentState!.validate()) {
        // Remove Loader
        FullScreenLoader.stopLoading();
        return;
      }

      // Privacy Policy Check
      if (!privacyPolicy.value) {
        Loaders.warningSnackBar(
          title: TTexts.acceptPrivacyPolicy,
          message: TTexts.inOrderToCreateAccount,
        );
        FullScreenLoader.stopLoading();
        return;
      }

      // Register user in Firebase Authentication & Save user data in Firestore
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
          email.text.trim(),
          password.text.trim()
      );

      // Save Authenticated user data in Firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        nameWithInitials: nameWithInitials.text.trim(),
        gender: gender.text.trim(),
        dateOfBirth: dateOfBirth.text.trim(),
        permanentAddress: permanentAddress.text.trim(),
        telephoneNumber: telephoneNumber.text.trim(),
        nationalIdentityCardNo: nationalIdentityCardNo.text.trim(),
        passportNo: passportNo.text.trim(),
        divisionalSecretariat: divisionalSecretariat.text.trim(),
        drivingLicenseNo: drivingLicenseNo.text.trim(),
        expiredClassOfVehicles: expiredClassOfVehicles.text.trim(),
        drivingLicenseIssuedDate: drivingLicenseIssuedDate.text.trim(),
        drivingLicenseExpiryDate: drivingLicenseExpiryDate.text.trim(),
        classOfVehiclesApplying: classOfVehiclesApplying.join(', '),
        email: email.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // Remove Loader
      FullScreenLoader.stopLoading();

      // Show Success Message
      Loaders.successSnackBar(
          title: TTexts.congratulations,
          message: TTexts.yourAccountHasBeenCreated
      );

      // Move to Verify Email Screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));

    } catch (e) {
      // Remove Loader
      FullScreenLoader.stopLoading();

      // Show some Generic Error to the user
      Loaders.errorSnackBar(
          title: TTexts.error,
          message: e.toString()
      );
    }
  }
}
