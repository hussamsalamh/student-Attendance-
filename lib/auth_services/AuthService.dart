import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth  = FirebaseAuth.instance;
class AuthService {

  late User user;

  AuthService(){
    _auth.userChanges().listen((event)=> user = event!);
  }

  Future<String> login(String email, String password) async {
    try{
     UserCredential user = await FirebaseAuth.instance.
     signInWithEmailAndPassword(email: email, password: password);
      return "Logged In";
    } catch(e) {
      return "error";
    }
  }

  Future<String?> signUp(String email, String password) async {
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) async {
        User? user = FirebaseAuth.instance.currentUser;

        await FirebaseFirestore.instance.collection("users").doc(user!.uid).set({
          'uid': user.uid,
          'email': email,
          'password': password,
        });
      });
      return "Signed Up";
    } catch(e) {
      return "error";
    }
  }
}