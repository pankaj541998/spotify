
import 'package:dartz/dartz.dart';
import 'package:spotify_bloc/domain/repositories/auth/auth_repo.dart';

import '../../../service_locator.dart';
import '../../models/auth/create_user_auth_modal.dart';
import '../../models/auth/signin_auth_model.dart';
import '../../source/auth/auth_firebase_services.dart';

class AuthRepositoryImpl extends AuthRepository{
  @override
  Future<Either> signIn(SigninRequestUser signinRequestUser)async {
    return await sl<AuthFirebaseService>().signIn(signinRequestUser);
  }

  @override
  Future<Either> signUp(CreateUserRequest createUserRequest)async {
    return await sl<AuthFirebaseService>().signUp(createUserRequest);
  }
  
  @override
  Future<Either> getUser() async{
     return await sl<AuthFirebaseService>().getUser();
  }
  
}