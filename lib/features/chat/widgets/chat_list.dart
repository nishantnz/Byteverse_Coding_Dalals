import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthai/common/widgets/loader.dart';
import 'package:healthai/features/chat/controller/chat_controllet.dart';
import 'package:healthai/features/chat/widgets/my_message_card.dart';
import 'package:healthai/features/chat/widgets/sender_message_card.dart';
import 'package:healthai/models/message.dart';
import 'package:intl/intl.dart';

class ChatLists extends ConsumerStatefulWidget {
  final String receiverUserId;
  const ChatLists({
    required this.receiverUserId,
    super.key,
  });

  @override
  ConsumerState<ChatLists> createState() => _ChatListsState();
}

class _ChatListsState extends ConsumerState<ChatLists> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
        stream: ref.read(chatControllerProvider).chatStream(
              receiverUserId: widget.receiverUserId,
            ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoaderWidget();
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final messageData = snapshot.data![index];
              var timeSent = DateFormat.Hm().format(messageData.timeSent);
              if (messageData.senderId != widget.receiverUserId) {
                // my message card
                return MyMessageCard(
                  message: messageData.text,
                  time: timeSent,
                );
              }
              // sender message card
              return SenderMessageCard(
                message: messageData.text,
                time: timeSent,
              );
            },
          );
        });
  }
}
