import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:provider/provider.dart';

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

class Profile {
  String? id;
  String? email;
}

class CountController extends GetxController {
  final profile = Profile();

  CountController();

  static Widget consumer(
          {required GetControllerBuilder<CountController> builder}) =>
      GetBuilder<CountController>(builder: builder);

  static CountController read() => Get.isRegistered<CountController>()?Get.find<CountController>():Get.put(CountController());

  void setProfile(Profile profile) {
    profile.id = profile.id;
    profile.email = profile.email;
    update();
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = CountController.read();

    return CountController.consumer(
      builder: (controller) {
        print("CountController.consumer rebuild : ${controller.profile}");
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
    var provider = CountController.read();

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
