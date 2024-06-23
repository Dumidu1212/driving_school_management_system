import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/formatters/formatter.dart';

/// Model class representing user data
class UserModel {
  // Keep those values final which you do not want to update
  final String id;
  String nameWithInitials;
  String gender;
  String dateOfBirth;
  String permanentAddress;
  String telephoneNumber;
  String nationalIdentityCardNo;
  String passportNo;
  String divisionalSecretariat;
  String drivingLicenseNo;
  String expiredClassOfVehicles;
  String drivingLicenseIssuedDate;
  String drivingLicenseExpiryDate;
  String classOfVehiclesApplying;
  final String email;
  String profilePicture;

  /// Constructor for userModel
  UserModel({
    required this.id,
    required this.nameWithInitials,
    required this.gender,
    required this.dateOfBirth,
    required this.permanentAddress,
    required this.telephoneNumber,
    required this.nationalIdentityCardNo,
    required this.passportNo,
    required this.divisionalSecretariat,
    required this.drivingLicenseNo,
    required this.expiredClassOfVehicles,
    required this.drivingLicenseIssuedDate,
    required this.drivingLicenseExpiryDate,
    required this.classOfVehiclesApplying,
    required this.email,
    required this.profilePicture,
  });

  /// Helper function to format phone number
  String get formattedPhoneNo => TFormatter.formatPhoneNumber(telephoneNumber);

  /// Static function to create an empty user model
  static UserModel empty() => UserModel(
      id: '',
      nameWithInitials: '',
      gender: '',
      dateOfBirth: '',
      permanentAddress: '',
      telephoneNumber: '',
      nationalIdentityCardNo: '',
      passportNo: '',
      divisionalSecretariat: '',
      drivingLicenseNo: '',
      expiredClassOfVehicles: '',
      drivingLicenseIssuedDate: '',
      drivingLicenseExpiryDate: '',
      classOfVehiclesApplying: '',
      email: '',
      profilePicture: '',
  );

  /// Convert model to JSON structure for staring data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'NameWithInitials': nameWithInitials,
      'Gender': gender,
      'DateOfBirth': dateOfBirth,
      'PermanentAddress': permanentAddress,
      'TelephoneNumber': telephoneNumber,
      'NationalIdentityCardNo': nationalIdentityCardNo,
      'PassportNo': passportNo,
      'DivisionalSecretariat': divisionalSecretariat,
      'DrivingLicenseNo': drivingLicenseNo,
      'ExpiredClassOfVehicles': expiredClassOfVehicles,
      'DrivingLicenseIssuedDate': drivingLicenseIssuedDate,
      'DrivingLicenseExpiryDate': drivingLicenseExpiryDate,
      'ClassOfVehiclesApplying': classOfVehiclesApplying,
      'Email': email,
      'ProfilePicture': profilePicture,
    };
  }

  /// Factory method to create a UserModel from a Firebase document snapshot
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        nameWithInitials: data['NameWithInitials'] ?? '',
        gender: data['Gender'] ?? '',
        dateOfBirth: data['DateOfBirth'] ?? '',
        permanentAddress: data['PermanentAddress'] ?? '',
        telephoneNumber: data['TelephoneNumber'] ?? '',
        nationalIdentityCardNo: data['NationalIdentityCardNo'] ?? '',
        passportNo: data['PassportNo'] ?? '',
        divisionalSecretariat: data['DivisionalSecretariat'] ?? '',
        drivingLicenseNo: data['DrivingLicenseNo'] ?? '',
        expiredClassOfVehicles: data['ExpiredClassOfVehicles'] ?? '',
        drivingLicenseIssuedDate: data['DrivingLicenseIssuedDate'] ?? '',
        drivingLicenseExpiryDate: data['DrivingLicenseExpiryDate'] ?? '',
        classOfVehiclesApplying: data['ClassOfVehiclesApplying'] ?? '',
        email: data['Email'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
      );
    } else {
      return UserModel.empty();
    }
  }
}
