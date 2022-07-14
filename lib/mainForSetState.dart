import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfilePage(),
    );
  }
}

class Profile {
  String? id;
  String? email;
}

class ProfilePage extends StatefulWidget {

  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Profile profile = Profile();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person, size: 200),
            Text("id : ${profile.id ?? ''}"),
            Text("email : ${profile.email ?? ''}"),
            ElevatedButton(
              child: const Text("프로필 변경하기"),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return ChangeProfileBottomSheet(profile);
                  },
                );
              },
            ),
            ElevatedButton(
              child: const Text("ProfilePage의 setState()"),
              onPressed: () {
                setState((){});
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ChangeProfileBottomSheet extends StatefulWidget {
  Profile profile;

  ChangeProfileBottomSheet(this.profile);

  @override
  State<ChangeProfileBottomSheet> createState() => _ChangeProfileBottomSheetState();
}

class _ChangeProfileBottomSheetState extends State<ChangeProfileBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
            decoration: InputDecoration(labelText: "id"),
            onChanged: (text) {
              widget.profile.id = text;
              setState((){});
            }),
        TextField(
            decoration: InputDecoration(labelText: "email"),
            onChanged: (text) {
              widget.profile.email = text;
              setState((){});
            }),
      ],
    );
  }
}
