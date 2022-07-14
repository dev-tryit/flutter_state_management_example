
abstract class ProfileEvent {}

class UpdateIdEvent extends ProfileEvent {
  String id;

  UpdateIdEvent(this.id);
}

class UpdateEmailEvent extends ProfileEvent {
  String email;

  UpdateEmailEvent(this.email);
}
