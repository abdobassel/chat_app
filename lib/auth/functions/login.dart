import 'package:chat_app/components.dart';
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

    ShowToast(text: 'Logged in', state: ToastStates.SUCCESS);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      ShowToast(text: e.toString(), state: ToastStates.WARNING);

      print('this user not found.');
    } else if (e.code == 'wrong-password') {
      print('wrong password.');
      ShowToast(text: e.toString(), state: ToastStates.ERROR);
    }
  } catch (e) {
    ShowToast(text: e.toString(), state: ToastStates.ERROR);
  }
}
