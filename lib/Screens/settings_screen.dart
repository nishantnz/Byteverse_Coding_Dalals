// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 30, horizontal: 4),
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.all(10),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 100,
                    child: Icon(Icons.person, size: 80),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Username surname',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'user-email@email.com',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                CommonWidget(Icons.person, 'Account'),
                CommonWidget(Icons.notifications, 'Notification'),
                CommonWidget(Icons.remove_red_eye, 'Appearance'),
                CommonWidget(Icons.shield_rounded, 'Privacy and Security'),
                CommonWidget(Icons.volume_up, 'Sound'),
                LogoutButton(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Logout',
            style: TextStyle(
              fontSize: 20,
              color: Colors.red,
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Icon(
              Icons.logout_rounded,
              color: Colors.red,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class CommonWidget extends StatelessWidget {
  final icon;
  final text;

  CommonWidget(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: Icon(icon),
              ),
              Text(
                text,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          Icon(Icons.arrow_forward_ios_sharp),
        ],
      ),
    );
  }
}
