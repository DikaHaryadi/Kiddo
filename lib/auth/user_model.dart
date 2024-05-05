import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  final String username;
  final String email;
  String profilePicture;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.profilePicture,
  });

  // to get the full name
  String get fullName => '$firstName $lastName';

  // to split full name into first and last name
  static List<String> nameParts(String fullName) => fullName.split(" ");

  // to generate a username from the full name
  static String generateUsername(String fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername = '$firstName$lastName';
    String usernameWithPrefix = 'cwt_$camelCaseUsername';
    return usernameWithPrefix;
  }

  // static func to create an empty user model
  static UserModel empty() => UserModel(
        id: '',
        firstName: '',
        lastName: '',
        username: '',
        email: '',
        profilePicture: '',
      );

  // Convert model to JSON structure for storing data in firebase
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Username': username,
      'Email': email,
      'ProfilePicture': profilePicture,
    };
  }

  // Factory method to create a UserModel from a Firebase document snapshot
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data();
      return UserModel(
        id: document.id,
        firstName: data?['FirstName'] ?? '',
        lastName: data?['LastName'] ?? '',
        username: data?['Username'] ?? '',
        email: data?['Email'] ?? '',
        profilePicture: data?['ProfilePicture'] ?? '',
      );
    } else {
      return UserModel.empty();
    }
  }
}
