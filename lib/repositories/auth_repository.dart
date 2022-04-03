import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final auth = FirebaseAuth.instance;

  User? get user => auth.currentUser;

  Future<String?> get token =>
      auth.currentUser?.getIdToken() ?? Future.value(null);

  bool get isLoggedIn =>
      auth.currentUser != null && auth.currentUser?.getIdToken() != null;

  Future<void> signUp({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          throw Exception('The password provided is too weak.');
        case 'email-already-in-use':
          throw Exception('The account already exists for that email.');
        case 'invalid-email':
          throw Exception('Email is not valid or badly formatted.');
        case 'user-disabled':
          throw Exception(
              'This user has been disabled. Please contact support for help.');
        case 'operation-not-allowed':
          throw Exception('Operation is not allowed.  Please contact support.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw Exception('No user found for that email.');
        case 'wrong-password':
          throw Exception('Wrong password provided for that user.');
        case 'invalid-email':
          throw Exception('Email is not valid or badly formatted.');
        case 'user-disabled':
          throw Exception(
              'This user has been disabled. Please contact support for help.');
        default:
          throw Exception('An error occurred');
      }
    } catch (e) {
      throw Exception('An error occurred');
    }
  }

  Future<void> signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
