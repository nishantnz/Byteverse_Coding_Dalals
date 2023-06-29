import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthai/common/enums/user_type_enum.dart';
import 'package:healthai/common/widgets/error.dart';
import 'package:healthai/common/widgets/loader.dart';
import 'package:healthai/features/auth/controller/auth_controller.dart';
import 'package:healthai/features/chat/screen/chat_screen.dart';
import 'package:healthai/models/doctor_model.dart';

class ListOfDoctors extends ConsumerWidget {
  const ListOfDoctors({
    Key? key,
  }) : super(key: key);

  static const routeName = '/list-of-doctors';

  void onTap({
    required WidgetRef ref,
    required BuildContext context,
    required DoctorModel doctorData,
  }) async {
    ref.read(authControllerProvider).savePatientToDoctorList(
          context: context,
          doctorId: doctorData.actualId,
        );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          name: doctorData.name,
          receiverUserId: doctorData.actualId,
          type: UserTypeEnum.patient,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Doctors'),
      ),
      body: StreamBuilder<List<DoctorModel>>(
        stream: ref.read(authControllerProvider).getListOfDoctorsController(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoaderPage();
          }
          return snapshot.data == null
              ? const ErrorScreen(
                  error:
                      'Error while retireving doctor list. please try again later',
                )
              : ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final doctorData = snapshot.data![index];
                    return InkWell(
                      onTap: () => onTap(
                        ref: ref,
                        context: context,
                        doctorData: doctorData,
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(doctorData.profilePic),
                          radius: 30,
                        ),
                        title: Text(doctorData.name),
                        subtitle: Text(
                          '${doctorData.expertise}, ${doctorData.address}',
                        ),
                        trailing: IconButton(
                          onPressed: () => onTap(
                            ref: ref,
                            context: context,
                            doctorData: doctorData,
                          ),
                          icon: const Icon(Icons.keyboard_arrow_right_sharp),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
