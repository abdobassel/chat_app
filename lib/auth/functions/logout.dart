import 'package:chat_app/components.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> logout() async {
  try {
    await FirebaseAuth.instance.signOut();
    ShowToast(text: 'Logged Out', state: ToastStates.SUCCESS);
  } on Exception catch (e) {
    ShowToast(text: e.toString(), state: ToastStates.ERROR);
  }
}
