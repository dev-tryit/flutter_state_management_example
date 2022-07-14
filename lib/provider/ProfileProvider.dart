
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile {
  String? id;
  String? email;
}

typedef ConsumerBuilderType<T> = Widget Function(
    BuildContext context, T provider, Widget? child);

class ProfileProvider extends ChangeNotifier {
  final profile = Profile();

  BuildContext context;

  ProfileProvider(this.context);

  static ChangeNotifierProvider get provider =>
      ChangeNotifierProvider<ProfileProvider>(
          create: (context) => ProfileProvider(context));

  static Widget consumer(
      {required ConsumerBuilderType<ProfileProvider> builder}) =>
      Consumer<ProfileProvider>(builder: builder);

  static ProfileProvider read(BuildContext context) =>
      context.read<ProfileProvider>();

  void setProfile(Profile profile) {
    profile.id = profile.id;
    profile.email = profile.email;
    notifyListeners();
  }
}