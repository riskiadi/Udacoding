import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository{

  GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<GoogleSignInAccount> handleSignIn() async {
    return await _googleSignIn.signIn();
  }

  Future<void> handleLogOut() async {
    await _googleSignIn.signOut();
  }

  Future<bool> isLogin() async{
    return await _googleSignIn.isSignedIn();
  }

}

class ContentRepository{

  FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;
  DatabaseReference _databaseReference;

  ContentRepository();

  Future<DataSnapshot> getContent() async {
    _databaseReference = _firebaseDatabase.reference();
    DataSnapshot dataSnapshot = await _databaseReference.once();
    return dataSnapshot;
  }

  Future<DatabaseReference> databaseReference() async {
    _databaseReference = _firebaseDatabase.reference();
    return _databaseReference;
  }

}

