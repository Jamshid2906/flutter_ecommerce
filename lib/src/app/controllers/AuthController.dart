import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  late final FirebaseAuth _firebaseAuth;

  AuthController(){
    this._firebaseAuth = FirebaseAuth.instance;
  }

  Future authStatus() async
  {
    return  _firebaseAuth.authStateChanges();
  }
  Future<String?> signUp(Map<String,dynamic> request) async
  {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: request['email'], password: request['password']);
      return "up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> signIn(Map<String,dynamic> request) async 
  {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: request['email'], password: request['password']);
      return "in";
    } on FirebaseAuthException catch  (e) {
      return e.message;
    }
  }

  Future<void> signOut() async
  {
    await _firebaseAuth.signOut();
  }
}