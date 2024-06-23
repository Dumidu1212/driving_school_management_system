
import 'package:cf_sarasavi_app/data/repositories/documents/documents_repository.dart';
import 'package:cf_sarasavi_app/features/personalization/models/documents_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/constants/text_strings.dart';
import '../../../utils/popups/loaders.dart';

class DocumentsController extends GetxController {
  static DocumentsController get instance => Get.find();

  Rx<DocumentsModel> documents = DocumentsModel.empty().obs;
  final documentImageUploading = false.obs;
  final documentsRepository = Get.put(DocumentsRepository());

  @override
  void onInit() {
    super.onInit();
    fetchDocumentsRecord();
  }

  /// Fetch documents record
  Future<void> fetchDocumentsRecord() async {
    try {
      // profileLoading.value = true;
      final documents = await documentsRepository.fetchDocumentDetails();
      this.documents(documents);
    } catch (e) {
      documents(DocumentsModel.empty());
    } finally {
      // profileLoading.value = false;
    }
  }

  Future<void> saveDocumentsRecord({String? photoURL}) async {
    try {
      // First Update Rx Documents and then check if documents data is already stored. If not store new data
      await fetchDocumentsRecord();

      // If no record already stored
      if (documents.value.id.isEmpty) {
        // Map Data
        final newDocument = DocumentsModel(
          id: documents.value.id,
          studentID: documents.value.studentID,
          medical: photoURL ?? '',
          birthCertificate: photoURL ?? '',
          identityCard: photoURL ?? '',
          expiredDrivingLicense: photoURL ?? '',
          lernerPermit: photoURL ?? '',
          medicalApproval: '',
          birthCertificateApproval: '',
          identityCardApproval: '',
          expiredDrivingLicenseApproval: '',
          lernerPermitApproval: '',
        );

        // Save user data
        await documentsRepository.saveDocumentsRecord(newDocument);
      }
    } catch (e) {
      TLoaders.warningSnackBar(
        title: TTexts.dataNotSaved,
        message: TTexts.somethingWentWrongWhileSavingYourInformation,
      );
    }
  }

  /// Upload Profile Image
  Future<void> uploadUserDocuments(String documentImage) async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );

      if (image != null) {
        documentImageUploading.value = true;

        // Upload Image
        final imageUrl = await documentsRepository.uploadDocumentImage('Users/Images/$documentImage/', image);


        // Update User Image Record
        Map<String, dynamic> json = {'Medical': imageUrl};
        await documentsRepository.updateSingleField(json);


        // Update the local documents model
        documents.value = documents.value.copyWith(
          medical: documentImage == 'medical' ? imageUrl : documents.value.medical,
          birthCertificate: documentImage == 'birthCertificate' ? imageUrl : documents.value.birthCertificate,
          identityCard: documentImage == 'identityCard' ? imageUrl : documents.value.identityCard,
          expiredDrivingLicense: documentImage == 'expiredDrivingLicense' ? imageUrl : documents.value.expiredDrivingLicense,
          lernerPermit: documentImage == 'lernerPermit' ? imageUrl : documents.value.lernerPermit,
        );
        documents.refresh();

        TLoaders.successSnackBar(
          title: TTexts.congratulations,
          message: TTexts.yourDocumentHasBeenUploaded,
        );
      }
    } catch (e) {
      TLoaders.errorSnackBar(
        title: TTexts.error,
        message: '${TTexts.somethingWentWrongError} $e',
      );
    } finally {
      documentImageUploading.value = false;
    }
  }



}