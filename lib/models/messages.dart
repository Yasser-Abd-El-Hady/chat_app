import 'package:cloud_firestore/cloud_firestore.dart';

class Messages {
  final String id;
  final String message;
  final Timestamp time;

  Messages(this.id, this.message, this.time);

  factory Messages.fromJson(jsonData) {
    return Messages(jsonData['id'], jsonData['message'], jsonData['time']);
  }
}
