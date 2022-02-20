import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuthService {
  Future<String> signIn(String email, String? password);
  Future<void> signOut();
  Future<User?> getCurrentUser();

}

class AuthService implements BaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static final AuthService _instance = AuthService._internal();
  factory AuthService() {
    return _instance;
  }

  AuthService._internal();

  @override
  Future<String> signIn(String email, String? password) async {
    var result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password!);
    var user = result.user!;
    return user.uid;
  }

  @override
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  @override
  Future<User?> getCurrentUser() async {
    var user = _firebaseAuth.currentUser;
    return user;
  }

}
