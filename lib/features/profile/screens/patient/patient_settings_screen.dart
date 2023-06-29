import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthai/common/widgets/loader.dart';
import 'package:healthai/features/profile/controller/profile_details_controller.dart';
import 'package:healthai/features/profile/screens/patient/patient_profile_screen.dart';
import 'package:healthai/features/profile/widgets/list_tile_widget.dart';
import 'package:healthai/features/profile/widgets/logout_button.dart';

class PatientSettingsPage extends ConsumerWidget {
  const PatientSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: FutureBuilder(
        future: ref
            .read(profileDetailsControllerProvider)
            .getPatientDetails(context),
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
                        backgroundImage:
                            NetworkImage(snapshot.data!.profilePic),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        snapshot.data!.name,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        snapshot.data!.email,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ListTileWidget(
                      icon: Icons.person,
                      text: 'Account',
                      onTap: () {
                        Navigator.pushNamed(
                            context, PatientProfilePage.routeName);
                      },
                    ),
                    ListTileWidget(
                        icon: Icons.notifications,
                        text: 'Notification',
                        onTap: () {}),
                    ListTileWidget(
                      icon: Icons.remove_red_eye,
                      text: 'Appearance',
                      onTap: () {},
                    ),
                    ListTileWidget(
                      icon: Icons.shield_rounded,
                      text: 'Privacy and Security',
                      onTap: () {},
                    ),
                    const LogoutButton(),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
