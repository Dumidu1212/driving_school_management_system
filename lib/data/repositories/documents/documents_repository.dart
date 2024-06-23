import 'dart:io';
import 'package:cf_sarasavi_app/features/personalization/models/documents_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/constants/text_strings.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class DocumentsRepository extends GetxController {
  static DocumentsRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Function to save document image data to Firestore
  Future<void> saveDocumentsRecord(DocumentsModel document) async {
    try {
      await _db.collection("Documents").doc(document.id).set(document.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw TTexts.somethingWentWrong;
    }
  }

  /// Function to fetch document details based on user ID
  Future<DocumentsModel> fetchDocumentDetails() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw TTexts.userNotLoggedIn;
      }

      final querySnapshot = await _db.collection('Documents').where('studentID', isEqualTo: currentUser.uid).get();

      if (querySnapshot.docs.isNotEmpty) {
        final documentSnapshot = querySnapshot.docs.first;
        return DocumentsModel.fromSnapshot(documentSnapshot);
      } else {
        return DocumentsModel.empty();
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw TTexts.somethingWentWrong;
    }
  }


  /// Update any field in specific Documents Collection
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw TTexts.userNotLoggedIn;
      }

      final documentSnapshot = await _db.collection('Documents').where('studentID', isEqualTo: currentUser.uid).get();

      if (documentSnapshot.docs.isEmpty) {
        throw TTexts.documentNotFound;
      }

      final documentReference = documentSnapshot.docs.first.reference;

      await documentReference.update(json);

    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw TTexts.somethingWentWrong;
    }
  }

  /// Upload any Image
  Future<String> uploadDocumentImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw TTexts.somethingWentWrongPleaseTryAgain;
    }
  }


}