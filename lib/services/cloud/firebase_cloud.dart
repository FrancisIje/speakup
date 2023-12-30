import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:speakup/models/user.dart';

class FirebaseCloud {
  Future<SpeakupUser?> getCurrentUser() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      // Handle the case where the current user is null
      return null;
    }

    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();

    // Check if userSnapshot contains data
    if (!userSnapshot.exists) {
      // Handle the case where the document does not exist
      return null;
    }

    // Ensure that userSnapshot.data is of the expected type
    Map<String, dynamic>? userData =
        userSnapshot.data() as Map<String, dynamic>?;

    if (userData == null) {
      // Handle the case where user data is null
      return null;
    }

    // Use null-aware operators to access properties safely
    return SpeakupUser.fromSpeakupUserMap(userData);
  }

  Future<void> updateUserData(Map<String, dynamic> userData) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser?.uid)
        .set(
          userData,
          SetOptions(merge: true),
        );
  }

  Future<void> deleteUserData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser?.uid)
        .delete();
  }

  static final FirebaseCloud _shared = FirebaseCloud._sharedInstance();
  FirebaseCloud._sharedInstance();
  factory FirebaseCloud() => _shared;
}
