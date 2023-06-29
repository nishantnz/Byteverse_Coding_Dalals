import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthai/features/chat/repository/chat_repository.dart';
import 'package:healthai/models/message.dart';

final chatControllerProvider = Provider((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  return ChatController(chatRepository, ref);
});

class ChatController {
  final ChatRepository chatRepository;
  final ProviderRef ref;

  ChatController(
    this.chatRepository,
    this.ref,
  );

  Stream<List<Message>> chatStream({required String receiverUserId}) {
    return chatRepository.getChatStream(receiverUserId: receiverUserId);
  }

  void sendTextMessageController(
    BuildContext context,
    String text,
    String receiverId,
  ) {
    chatRepository.sendTextMessage(
      context: context,
      text: text,
      receiverUserId: receiverId,
    );
  }
}
