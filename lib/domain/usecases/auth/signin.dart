
import 'package:dartz/dartz.dart';
import 'package:spotify_bloc/service_locator.dart';

import '../../../core/usecase/usecase.dart';
import '../../../data/models/auth/signin_auth_model.dart';
import '../../repositories/auth/auth_repo.dart';

class SignUInUsecase extends UseCase<Either,SigninRequestUser> {
  @override
  Future<Either> call({SigninRequestUser? params})async {
    return sl<AuthRepository>().signIn(params!);
  }
}