import 'package:firebase_auth/firebase_auth.dart';
import 'package:frank/models/user.dart';
import 'package:frank/services/account.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // create user object based on FirebaseUser
  MyUser _userFromFirebaseUser(User user) {
    return user != null
        ? MyUser(
            uid: user.uid,
            email: user.email,
            displayName: user.displayName,
            photoURL: user.photoURL)
        : null;
  }

  Stream<MyUser> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // sign in with Google
  Future signInWithGoogle() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      UserCredential result = await _auth.signInWithCredential(credential);
      User user = result.user;
      AccountService accountService = AccountService(uid: user.email);

      await accountService.isKnown().then((data) {
        if (data) {
        } else {
          accountService.register(
              user.email, user.displayName, user.photoURL, -2);
        }
      });

      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error);
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
