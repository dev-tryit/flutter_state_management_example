
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ProfileEvent.dart';
import 'ProfileState.dart';

class Profile {
  String? id;
  String? email;
}

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final profile = Profile();

  ProfileBloc() : super(InitProfileState()) {
    on<UpdateIdEvent>((event, emit) {
      profile.id = event.id;

      emit(UpdatedProfileIdState());
    });

    on<UpdateEmailEvent>((event, emit) {
      profile.email = event.email;

      emit(UpdatedProfileEmailState());
    });
  }

  static BlocProvider<ProfileBloc> get provider =>
      BlocProvider<ProfileBloc>(create: (context) => ProfileBloc());

  static Widget consumer({required BlocWidgetBuilder<ProfileState> builder}) =>
      BlocBuilder<ProfileBloc, ProfileState>(builder: builder);

  static ProfileBloc read(BuildContext context) =>
      BlocProvider.of<ProfileBloc>(context);
}