
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class Profile {
  String? id;
  String? email;
}

class ProfileController extends GetxController {
  final profile = Profile();

  ProfileController();

  static Widget consumer(
      {required GetControllerBuilder<ProfileController> builder}) =>
      GetBuilder<ProfileController>(builder: builder);

  static ProfileController instsance() => Get.isRegistered<ProfileController>()?Get.find<ProfileController>():Get.put(ProfileController());

  void setProfile(Profile profile) {
    profile.id = profile.id;
    profile.email = profile.email;
    update();
  }
}
