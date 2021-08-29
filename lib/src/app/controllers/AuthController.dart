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
    var email = request['email'].toString().trim();
    var password = request['password'].toString().trim();
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return "up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> signIn(Map<String,dynamic> request) async 
  {
    var email = request['email'].toString().trim();
    var password = request['password'].toString().trim();
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
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