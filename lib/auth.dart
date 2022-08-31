import 'package:firebase_auth/firebase_auth.dart';


class Users{
  final String uid;
  Users({required this.uid});
}

class Auth{

  final authResult = FirebaseAuth.instance;
  Users? userFromFirebase(User user)
  {
    if(user == null)
      {
        return null;
      }
    return Users(uid: user.uid);
  }

  Future<Users?> signInWithEmailAddress(String email, String password) async
  {
    final result =await authResult.signInWithEmailAndPassword(email: email, password: password);
    return userFromFirebase(result.user!);
  }

  Future<Users?> createAccountWithEmailAddress(String email, String password)async
  {
    final result = await authResult.createUserWithEmailAndPassword(email: email, password: password);
    return userFromFirebase(result.user!);
  }

  Stream<Users?> get onAuthStateChange{
    return authResult.authStateChanges().map((user) => userFromFirebase(user!));
  }

  void signOut()
  {
     authResult.currentUser;
    authResult.signOut();
  }
}