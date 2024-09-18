import 'package:get_it/get_it.dart';
import 'package:spotify_bloc/data/repositories/songs/song_repo_impl.dart';
import 'package:spotify_bloc/data/source/auth/auth_firebase_services.dart';
import 'package:spotify_bloc/domain/repositories/songs/songs.dart';
import 'package:spotify_bloc/domain/usecases/auth/signup.dart';
import 'package:spotify_bloc/domain/usecases/songs/get_playlist.dart';

import 'data/repositories/auth/auth_repository_impl.dart';
import 'data/source/song/song_firebase_service.dart';
import 'domain/repositories/auth/auth_repo.dart';
import 'domain/usecases/auth/signin.dart';
import 'domain/usecases/songs/get_songs.dart';

final sl = GetIt.instance;

Future<void>initializeDependencies()async{
  
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());
  sl.registerSingleton<SongFirebaseService>(SongsFirebaseServiceimpl());
  

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<SongsRepository>(SongRepositoryImpl());
  
  sl.registerSingleton<SignUpUsecase>(SignUpUsecase());
  
  sl.registerSingleton<SignUInUsecase>(SignUInUsecase());
  sl.registerSingleton<GetNewSongsUsecases>(GetNewSongsUsecases());
  sl.registerSingleton<GetPlayListUsecases>(GetPlayListUsecases());
}