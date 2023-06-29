import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthai/common/enums/user_type_enum.dart';
import 'package:healthai/common/widgets/error.dart';
import 'package:healthai/common/widgets/loader.dart';
import 'package:healthai/features/auth/controller/auth_controller.dart';
import 'package:healthai/features/chat/screen/chat_screen.dart';
import 'package:healthai/models/user_model.dart';
import 'package:lottie/lottie.dart';

class ListofPatients extends ConsumerWidget {
  const ListofPatients({
    Key? key,
  }) : super(key: key);

  static const routeName = '/list-of-patients';

  void onTap({
    required WidgetRef ref,
    required BuildContext context,
    required UserModel users,
  }) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          name: users.name,
          receiverUserId: users.actualId,
          type: UserTypeEnum.doctor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recent Messages'),
      ),
      body: StreamBuilder<List<UserModel>>(
        stream: ref.read(authControllerProvider).getListOfPatientsController(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoaderPage();
          }
          return snapshot.data == null
              ? const ErrorScreen(
                  error:
                      'Error while retireving patient list. please try again later',
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final users = snapshot.data![index];
                      return InkWell(
                        onTap: () => onTap(ref: ref, context: context, users: users),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(
                              users.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: SizedBox(
                              width: 50,
                              height: 50,
                              child: Lottie.asset(
                                "assets/files/lab_result.json",
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}
