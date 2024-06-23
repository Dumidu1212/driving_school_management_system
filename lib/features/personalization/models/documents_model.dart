import 'package:cloud_firestore/cloud_firestore.dart';

class DocumentsModel {
  final String id;
  final String studentID;
  String medical;
  String birthCertificate;
  String identityCard;
  String expiredDrivingLicense;
  String lernerPermit;
  String medicalApproval;
  String birthCertificateApproval;
  String identityCardApproval;
  String expiredDrivingLicenseApproval;
  String lernerPermitApproval;

  DocumentsModel({
    required this.id,
    required this.studentID,
    required this.medical,
    required this.birthCertificate,
    required this.identityCard,
    required this.expiredDrivingLicense,
    required this.lernerPermit,
    required this.medicalApproval,
    required this.birthCertificateApproval,
    required this.identityCardApproval,
    required this.expiredDrivingLicenseApproval,
    required this.lernerPermitApproval,
  });


  static DocumentsModel empty() =>
      DocumentsModel(
        id: '',
        studentID: '',
        medical: '',
        birthCertificate: '',
        identityCard: '',
        expiredDrivingLicense: '',
        lernerPermit: '',
        medicalApproval: 'Upload',
        birthCertificateApproval: 'Upload',
        identityCardApproval: 'Upload',
        expiredDrivingLicenseApproval: 'Upload',
        lernerPermitApproval: 'Upload',
      );

  Map<String, dynamic> toJson() {
    return {
      'StudentID': studentID,
      'Medical': medical,
      'BirthCertificate': birthCertificate,
      'IdentityCard': identityCard,
      'ExpiredDrivingLicense': expiredDrivingLicense,
      'LernerPermit': lernerPermit,
      'MedicalApproval': medicalApproval,
      'BirthCertificateApproval': birthCertificateApproval,
      'IdentityCardApproval': identityCardApproval,
      'ExpiredDrivingLicenseApproval': expiredDrivingLicenseApproval,
      'LernerPermitApproval': lernerPermitApproval,
    };
  }

  // Add copyWith method
  DocumentsModel copyWith({
    String? id,
    String? studentID,
    String? medical,
    String? birthCertificate,
    String? identityCard,
    String? expiredDrivingLicense,
    String? lernerPermit,
    String? medicalApproval,
    String? birthCertificateApproval,
    String? identityCardApproval,
    String? expiredDrivingLicenseApproval,
    String? lernerPermitApproval,
  }) {
    return DocumentsModel(
      id: id ?? this.id,
      studentID: studentID ?? this.studentID,
      medical: medical ?? this.medical,
      birthCertificate: birthCertificate ?? this.birthCertificate,
      identityCard: identityCard ?? this.identityCard,
      expiredDrivingLicense: expiredDrivingLicense ?? this.expiredDrivingLicense,
      lernerPermit: lernerPermit ?? this.lernerPermit,
      medicalApproval: medicalApproval ?? this.medicalApproval,
      birthCertificateApproval: birthCertificateApproval ?? this.birthCertificateApproval,
      identityCardApproval: identityCardApproval ?? this.identityCardApproval,
      expiredDrivingLicenseApproval: expiredDrivingLicenseApproval ?? this.expiredDrivingLicenseApproval,
      lernerPermitApproval: lernerPermitApproval ?? this.lernerPermitApproval,
    );
  }

  factory DocumentsModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return DocumentsModel(id: document.id,
        studentID: data['StudentID'] ?? '',
        medical: data['Medical'] ?? '',
        birthCertificate: data['BirthCertificate'] ?? '',
        identityCard: data['IdentityCard'] ?? '',
        expiredDrivingLicense: data['ExpiredDrivingLicense'] ?? '',
        lernerPermit: data['LernerPermit'] ?? '',
        medicalApproval: data['MedicalApproval'] ?? 'Upload',
        birthCertificateApproval: data['BirthCertificateApproval'] ?? 'Upload',
        identityCardApproval: data['IdentityCardApproval'] ?? 'Upload',
        expiredDrivingLicenseApproval: data['ExpiredDrivingLicenseApproval'] ?? 'Upload',
        lernerPermitApproval: data['LernerPermitApproval'] ?? 'Upload',
      );
    } else {
      return DocumentsModel.empty();
    }
  }

}
