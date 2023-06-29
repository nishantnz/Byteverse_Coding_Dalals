import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:healthai/colors.dart';
import 'package:healthai/features/chat/controller/chat_controllet.dart';
import 'package:healthai/features/reports/screens/patient/choose_report_to_send.dart';

class BottomChatField extends ConsumerStatefulWidget {
  final String receiverUserId;
  const BottomChatField({
    super.key,
    required this.receiverUserId,
  });

  @override
  ConsumerState<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends ConsumerState<BottomChatField> {
  bool isShowSendButton = false;

  final TextEditingController _messageController = TextEditingController();

  void sendTextMessage() {
    if (isShowSendButton) {
      ref.read(chatControllerProvider).sendTextMessageController(
            context,
            _messageController.text,
            widget.receiverUserId,
          );
      setState(() {
        _messageController.text = '';
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _messageController,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    isShowSendButton = true;
                  });
                } else {
                  setState(() {
                    isShowSendButton = false;
                  });
                }
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: mobileChatBoxColor,
                suffixIcon: SizedBox(
                  width: size.width * 0.75 * 0.35,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.camera_alt,
                          color: Colors.grey,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChooseReportToSend(
                                doctorUserId: widget.receiverUserId,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.attach_file,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                hintText: 'Type a message!',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                contentPadding: const EdgeInsets.all(10),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8, right: 2, left: 2),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: whatsGreenColor,
              child: GestureDetector(
                onTap: isShowSendButton ? sendTextMessage : null,
                child: const Icon(
                  color: whiteColor,
                  size: 25,
                  Icons.send,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
