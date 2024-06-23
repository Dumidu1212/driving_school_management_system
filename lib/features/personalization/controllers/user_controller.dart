import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/repositories/repositories.authentication/authentication_repository.dart';
import '../../../data/repositories/user/user_repository.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../../authentication/screens/login/login.dart';
import '../../authentication/screens/re_authenticate_user/re_authenticate_user_login_form.dart';
import '../models/user_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final hidePassword = false.obs;
  final imageUploading = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  /// Fetch user record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  /// Save user record from any registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      // First Update Rx User and then check if user data is already stored. If not store new data
      await fetchUserRecord();

      // If no record already stored
      if(user.value.id.isEmpty) {
        if (userCredentials != null && userCredentials.user != null) {
          // Map Data
          final user = UserModel(
            id: userCredentials.user!.uid,
            nameWithInitials: userCredentials.additionalUserInfo
                ?.profile?['nameWithInitials'] ?? '',
            gender: userCredentials.additionalUserInfo?.profile?['gender'] ?? '',
            dateOfBirth: userCredentials.additionalUserInfo
                ?.profile?['dateOfBirth'] ?? '',
            permanentAddress: userCredentials.additionalUserInfo
                ?.profile?['permanentAddress'] ?? '',
            telephoneNumber: userCredentials.additionalUserInfo
                ?.profile?['telephoneNumber'] ?? '',
            nationalIdentityCardNo: userCredentials.additionalUserInfo
                ?.profile?['nationalIdentityCardNo'] ?? '',
            passportNo: userCredentials.additionalUserInfo
                ?.profile?['passportNo'] ?? '',
            divisionalSecretariat: userCredentials.additionalUserInfo
                ?.profile?['divisionalSecretariat'] ?? '',
            drivingLicenseNo: userCredentials.additionalUserInfo
                ?.profile?['drivingLicenseNo'] ?? '',
            expiredClassOfVehicles: userCredentials.additionalUserInfo
                ?.profile?['expiredClassOfVehicles'] ?? '',
            drivingLicenseIssuedDate: userCredentials.additionalUserInfo
                ?.profile?['drivingLicenseIssuedDate'] ?? '',
            drivingLicenseExpiryDate: userCredentials.additionalUserInfo
                ?.profile?['drivingLicenseExpiryDate'] ?? '',
            classOfVehiclesApplying: userCredentials.additionalUserInfo
                ?.profile?['classOfVehiclesApplying'] ?? '',
            email: userCredentials.user!.email ?? '',
            profilePicture: userCredentials.user!.photoURL ?? '',
          );

          // Save user data
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      TLoaders.warningSnackBar(
        title: TTexts.dataNotSaved,
        message: TTexts.somethingWentWrongWhileSavingYourInformation,
      );
    }
  }

  /// Delete Account Warning
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(TSizes.md),
      title: TTexts.deleteAccount,
      middleText: TTexts.areYouSureYouWantToDeleteAccount,
      confirm: ElevatedButton(
        onPressed: () async => deleteUserAccount(),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
        child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: TSizes.lg),
            child: Text(TTexts.delete)),
      ),
      cancel: OutlinedButton(
        child: const Text(TTexts.cancel),
        onPressed: () => Navigator.of(Get.overlayContext!).pop()),
    );
  }

  /// Delete User Account
  void deleteUserAccount() async {
    try {
      FullScreenLoader.openLoadingDialog(TTexts.processing, TImages.processingAnimation);

      /// First re-authenticate user
      final auth = AuthenticationRepository.instance;
      final provider = auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        // Re Verify Auth Email
        if (provider == 'password') {
          FullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      FullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(title: TTexts.error, message: e.toString());
    }

  }

  /// -- RE-AUTHENTICATE before deleting
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      FullScreenLoader.openLoadingDialog(TTexts.processing, TImages.processingAnimation);

      // Check Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      if (!reAuthFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.reAuthenticateWithEmailAndPassword(verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      FullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      FullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(title: TTexts.error, message: e.toString());
    }
  }

  /// Upload Profile Image
  uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70, maxHeight: 512, maxWidth: 512);
      if(image != null) {
        imageUploading.value = true;
        // Upload Image
        final imageUrl = await userRepository.uploadImage('Users/Images/Profile/', image);

        // Update User Image Record
        Map<String, dynamic> json = {'ProfilePicture' : imageUrl};
        await userRepository.updateSingleField(json);

        user.value.profilePicture = imageUrl;
        user.refresh();

        TLoaders.successSnackBar(title: TTexts.congratulations, message: TTexts.yourProfileImageHasBeenUpdated);
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: TTexts.error, message: '${TTexts.somethingWentWrongError}$e');
    } finally {
      imageUploading.value = false;
    }
  }

}
