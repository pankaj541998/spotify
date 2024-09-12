import 'package:dartz/dartz.dart';
import 'package:spotify_bloc/data/models/auth/create_user_auth_modal.dart';

import '../../../data/models/auth/signin_auth_model.dart';

abstract class AuthRepository {

  Future<Either> signUp(CreateUserRequest createUserRequest);

  Future<Either> signIn(SigninRequestUser signinRequestUser);

}
