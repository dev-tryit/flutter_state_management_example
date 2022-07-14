import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ProfileProvider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ProfileProvider.provider,
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProfilePage(),
    );
  }
}


class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileProvider.consumer(
      builder: (BuildContext context, ProfileProvider provider, Widget? child) {
        print("ProfileProvider rebuild : profile:${provider.profile}");
        return Scaffold(
          body: SizedBox.expand(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.person, size: 200),
                Text("id : ${provider.profile.id ?? ''}"),
                Text("email : ${provider.profile.email ?? ''}"),
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
    var provider = ProfileProvider.read(context);

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
