import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:healthai/colors.dart';
import 'package:healthai/common/enums/user_type_enum.dart';
import 'package:healthai/common/widgets/loader.dart';
import 'package:healthai/features/chat/widgets/bottom_chat_field.dart';
import 'package:healthai/features/chat/widgets/chat_list.dart';
import 'package:healthai/features/profile/controller/profile_details_controller.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({
    Key? key,
    required this.name,
    required this.receiverUserId,
    required this.type,
  }) : super(key: key);

  final String name;
  final String receiverUserId;
  final UserTypeEnum type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future:
          ref.read(profileDetailsControllerProvider).getPatientDetails(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoaderPage();
        }
        debugPrint('${snapshot.data!.toMap()}');
        return Scaffold(
          appBar: AppBar(
            backgroundColor: appBarColor,
            title: Text(name),
            centerTitle: false,
          ),
          body: Column(
            children: [
              Expanded(
                child: ChatLists(receiverUserId: receiverUserId),
              ),
              BottomChatField(
                receiverUserId: receiverUserId,
              ),
            ],
          ),
        );
      },
    );
  }
}
