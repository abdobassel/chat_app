import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String id;
  final String text;
  final String sId; // Sender ID
  final String rId; // Receiver ID
  final DateTime dt; // DateTime

  Message({
    required this.id,
    required this.text,
    required this.sId,
    required this.rId,
    required this.dt,
  });

  // تحويل وثيقة Firestore إلى كائن Message
  factory Message.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Message(
      id: doc.id,
      text: data['text'] ?? '',
      sId: data['s_id'] ?? '',
      rId: data['r_id'] ?? '',
      dt: (data['dt'] as Timestamp).toDate(),
    );
  }

  // تحويل كائن Message إلى خريطة ليتم حفظها في Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'text': text,
      's_id': sId,
      'r_id': rId,
      'dt': dt,
    };
  }
}
