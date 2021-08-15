import 'package:cam_stream/pages/auth/presntation/controllers/auth_controller.dart';
import 'package:cam_stream/pages/profile/presentation/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'User Profile',
              style: TextStyle(fontSize: 30, color: Colors.orangeAccent),
            ),
            SizedBox(
              height: 16,
            ),
            controller.user.photoURL !=null ?CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage(controller.user.photoURL!),
            ):Container(),
            SizedBox(
              height: 10,
            ),
            Text(
              'Display Name : ${controller.user.displayName}',
              style: TextStyle(fontSize: 18, color: Colors.orangeAccent),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              controller.user.email!,
              style: TextStyle(fontSize: 16, color: Colors.orangeAccent),
            ),
            SizedBox(
              height: 10,
            ),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 120),
              child: ElevatedButton(
                child: Text(
                  "Logout",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                onPressed: () {
                  
                  controller.logout();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
