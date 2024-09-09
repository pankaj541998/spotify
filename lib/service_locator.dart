import 'package:get_it/get_it.dart';
import 'package:spotify_bloc/data/source/auth/auth__firebase_services.dart';
import 'package:spotify_bloc/domain/usecases/auth/signup.dart';

import 'data/repositories/auth/auth_repository_impl.dart';
import 'domain/repositories/auth/auth_repo.dart';
import 'domain/usecases/auth/signin.dart';

final sl = GetIt.instance;

Future<void>initializeDependencies()async{
  
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  
  sl.registerSingleton<SignUpUsecase>(SignUpUsecase());
  
  sl.registerSingleton<SignUInUsecase>(SignUInUsecase());
}