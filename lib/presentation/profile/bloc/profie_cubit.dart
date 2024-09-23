import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_bloc/domain/usecases/auth/get_user.dart';
import 'package:spotify_bloc/presentation/profile/bloc/profile_state.dart';
import 'package:spotify_bloc/service_locator.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileLoading());

  Future<void> getUser() async {
    var user = await sl<GetProfileUsecase>().call();

    return user.fold((l) {
      emit(ProfileFailure());
    }, (userEntity) {
      emit(ProfileLoadded(userEntity: userEntity));
    });
  }
}
