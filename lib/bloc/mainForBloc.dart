import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'ProfileBloc.dart';
import 'ProfileEvent.dart';
import 'ProfileState.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      ProfileBloc.provider,
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


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    ProfileBloc bloc = ProfileBloc.read(context);

    return ProfileBloc.consumer(
      builder: (BuildContext context, ProfileState state) {
        return Scaffold(
          body: SizedBox.expand(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.person, size: 200),
                Text("id : ${bloc.profile.id ?? ''}"),
                Text("email : ${bloc.profile.email ?? ''}"),
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
                Text("현재 state : ${state.toString()}")
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
    var bloc = ProfileBloc.read(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
            decoration: InputDecoration(labelText: "id"),
            onChanged: (text) => bloc.add(UpdateIdEvent(text))),
        TextField(
            decoration: InputDecoration(labelText: "email"),
            onChanged: (text) => bloc.add(UpdateEmailEvent(text))),
      ],
    );
  }
}
