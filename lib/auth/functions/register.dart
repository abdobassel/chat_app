import 'package:chat_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> register({required String email, required String password}) async {
  try {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    token = credential.user!.uid;
    print(credential.user!.uid);
    print('success register');
    print(token);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}
