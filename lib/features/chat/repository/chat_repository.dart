import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'package:healthai/common/widgets/common_snackbar.dart';
import 'package:healthai/models/message.dart';

final chatRepositoryProvider = Provider(
  (ref) => ChatRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  ),
);

class ChatRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  ChatRepository({
    required this.firestore,
    required this.auth,
  });

  Stream<List<Message>> getChatStream({
    required String receiverUserId,
    
  }) {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverUserId)
        .collection('messages')
        .orderBy('timeSent')
        .snapshots()
        .map((event) {
      List<Message> messages = [];
      debugPrint("chat docs length ${event.docs.length}");
      if (event.docs.length == 1){
        
      }
      for (var element in event.docs) {
        messages.add(Message.fromMap(element.data()));
      }
      return messages;
    });
  }

  void _saveMessageToMessageSubcollection({
    required String receiverUserId,
    required String text,
    required DateTime timeSent,
    required String messageId,
  }) async {
    final message = Message(
      senderId: auth.currentUser!.uid,
      recieverid: receiverUserId,
      text: text,
      timeSent: timeSent,
      messageId: messageId,
    );
    // users -> sender user id -> receiver user id -> messages -> message id -> text
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverUserId)
        .collection('messages')
        .doc(messageId)
        .set(message.toMap());

    // users -> receiver user id -> sender user id -> messages -> message id -> text
    await firestore
        .collection('users')
        .doc(receiverUserId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .collection('messages')
        .doc(messageId)
        .set(message.toMap());
  }

  void sendTextMessage({
    required BuildContext context,
    required String text,
    required String receiverUserId,
  }) async {
    try {
      var timeSent = DateTime.now();

      var messageId = const Uuid().v1();
      debugPrint("hello");
      _saveMessageToMessageSubcollection(
        receiverUserId: receiverUserId,
        text: text,
        timeSent: timeSent,
        messageId: messageId,
      );
    } catch (e) {
      showsnackbar(
        context: context,
        msg: e.toString(),
      );
    }
  }
}
