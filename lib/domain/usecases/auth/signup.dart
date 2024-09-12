import 'package:spotify_bloc/domain/repositories/auth/auth_repo.dart';

import '../../../core/usecase/usecase.dart';
import '../../../data/models/auth/create_user_auth_modal.dart';
import 'package:dartz/dartz.dart';

import '../../../service_locator.dart';

class SignUpUsecase extends UseCase<Either,CreateUserRequest> {
  @override
  Future<Either> call({CreateUserRequest? params})async {
    return sl<AuthRepository>().signUp(params!);
  }
}