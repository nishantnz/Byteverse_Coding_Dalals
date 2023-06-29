import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthai/common/enums/user_type_enum.dart';
import 'package:healthai/common/widgets/loader.dart';
import 'package:healthai/features/profile/controller/profile_details_controller.dart';
import 'package:healthai/features/profile/screens/common/change_name_screen.dart';
import 'package:healthai/features/profile/screens/common/change_pic_screen.dart';
import 'package:healthai/features/profile/widgets/list_tile_widget.dart';
import 'package:healthai/features/profile/widgets/logout_button.dart';

class DoctorProfilePage extends ConsumerWidget {
  const DoctorProfilePage({super.key});
  static const routeName = '/doctor-profile-Page';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profiles'),
      ),
      body: FutureBuilder(
          future: ref
              .read(profileDetailsControllerProvider)
              .getDoctorDetails(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoaderPage();
            }
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 4),
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.all(10),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 100,
                          backgroundImage: NetworkImage(
                            snapshot.data!.profilePic,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 30, top: 20),
                        child: Text(
                          snapshot.data!.name,
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      ListTileWidget(
                        icon: Icons.person,
                        text: 'Change Name',
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) =>
                                  ChangeNameScreen(type: UserTypeEnum.doctor),
                            ),
                          );
                        },
                      ),
                      ListTileWidget(
                        icon: Icons.email_outlined,
                        text: 'Change Email',
                        onTap: () {},
                      ),
                      ListTileWidget(
                        icon: Icons.password_rounded,
                        text: 'Change Password',
                        onTap: () {},
                      ),
                      ListTileWidget(
                        icon: Icons.photo_camera,
                        text: 'Change Profile Picture',
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ChangePicScreen(type: UserTypeEnum.doctor),
                            ),
                          );
                        },
                      ),
                      const LogoutButton(),
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}
