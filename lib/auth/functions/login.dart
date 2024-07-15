import 'package:chat_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> login({required String email, required String password}) async {
  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    print(credential.user!.uid);
    token = credential.user!.uid;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('this user not found.');
    } else if (e.code == 'wrong-password') {
      print('wrong password.');
    }
  } catch (e) {
    print(e);
  }
}
