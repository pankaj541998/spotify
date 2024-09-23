import 'package:spotify_bloc/domain/entities/auth/user.dart';

abstract class ProfileState{}

class ProfileLoading extends ProfileState{}
class ProfileLoadded extends ProfileState{
  final UserEntity userEntity;

  ProfileLoadded({required this.userEntity});
}
class ProfileFailure extends ProfileState{}