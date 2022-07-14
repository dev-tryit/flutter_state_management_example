import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:provider/provider.dart';

import 'ProfileController.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = ProfileController.instsance();

    return ProfileController.consumer(
      builder: (_) {
        print("ProfileController.consumer rebuild : ${controller.profile}");
        return Scaffold(
          body: SizedBox.expand(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.person, size: 200),
                Text("id : ${controller.profile.id ?? ''}"),
                Text("email : ${controller.profile.email ?? ''}"),
                ElevatedButton(
                  child: const Text("프로필 변경하기"),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return ChangeProfileBottomSheet();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ChangeProfileBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = ProfileController.instsance();

    return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
              decoration: InputDecoration(labelText: "id"),
              onChanged: (text) =>
                  provider.setProfile(provider.profile..id = text)),
          TextField(
              decoration: InputDecoration(labelText: "email"),
              onChanged: (text) =>
                  provider.setProfile(provider.profile..email = text)),
        ],
    );
  }
}
