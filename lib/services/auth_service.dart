import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get current user
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign in with email
  Future<UserCredential> signInWithEmail(String email, String password) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  // Register new user
  Future<UserModel> registerUser(String email, String password, String name, String userType) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = UserModel(
      id: credential.user!.uid,
      name: name,
      email: email,
      userType: userType,
      linkedAccounts: [],
    );

    await _db.collection('users').doc(user.id).set(user.toJson());
    return user;
  }

  // Link child to parent
  Future<bool> linkChildToParent(String childCode, String parentId) async {
    try {
      final querySnap = await _db
          .collection('users')
          .where('childCode', isEqualTo: childCode)
          .get();

      if (querySnap.docs.isEmpty) return false;

      final childDoc = querySnap.docs.first;
      final parentDoc = await _db.collection('users').doc(parentId).get();

      // Update child's linked accounts
      await childDoc.reference.update({
        'linkedAccounts': FieldValue.arrayUnion([parentId])
      });

      // Update parent's linked accounts
      await parentDoc.reference.update({
        'linkedAccounts': FieldValue.arrayUnion([childDoc.id])
      });

      return true;
    } catch (e) {
      print('Error linking child: $e');
      return false;
    }
  }

  // Sign out
  Future<void> signOut() => _auth.signOut();
}
