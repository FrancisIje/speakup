class SpeakupUser {
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String targetLanguage;
  String targetLangLevel;
  String nativeLanguage;
  String tutorGender;
  String profilePictureUrl;
  List<String>? vocWords;

  SpeakupUser(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.phoneNumber,
      required this.targetLanguage,
      required this.targetLangLevel,
      required this.nativeLanguage,
      required this.profilePictureUrl,
      required this.tutorGender,
      this.vocWords});

  Map<String, dynamic> toSpeakupUserMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'targetLanguage': targetLanguage,
      'targetLangLevel': targetLangLevel,
      'nativeLanguage': nativeLanguage,
      'profilePictureUrl': profilePictureUrl,
      'tutorGender': tutorGender,
      'vocWords': vocWords
    };
  }

  static SpeakupUser fromSpeakupUserMap(Map<String, dynamic> map) {
    List<String>? vocWords =
        (map['vocWords'] as List<dynamic>?)?.cast<String>();
    return SpeakupUser(
        firstName: map['firstName'] ?? "",
        lastName: map['lastName'] ?? "",
        email: map['email'] ?? "",
        phoneNumber: map['phoneNumber'] ?? "",
        targetLanguage: map['targetLanguage'] ?? "",
        targetLangLevel: map['targetLangLevel'] ?? "",
        nativeLanguage: map['nativeLanguage'] ?? "",
        profilePictureUrl: map['profilePictureUrl'] ?? "",
        tutorGender: map['tutorGender'] ?? "",
        vocWords: vocWords);
  }
}
