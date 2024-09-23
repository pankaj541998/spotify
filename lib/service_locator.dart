import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:spotify_bloc/data/repositories/songs/song_repo_impl.dart';
import 'package:spotify_bloc/data/source/auth/auth_firebase_services.dart';
import 'package:spotify_bloc/domain/repositories/songs/songs.dart';
import 'package:spotify_bloc/domain/usecases/auth/get_user.dart';
import 'package:spotify_bloc/domain/usecases/auth/signup.dart';
import 'package:spotify_bloc/domain/usecases/songs/add_remove_fav_song.dart';
import 'package:spotify_bloc/domain/usecases/songs/get_playlist.dart';
import 'package:spotify_bloc/domain/usecases/songs/is_fav_song.dart';

import 'data/repositories/auth/auth_repository_impl.dart';
import 'data/source/song/song_firebase_service.dart';
import 'domain/repositories/auth/auth_repo.dart';
import 'domain/usecases/auth/signin.dart';
import 'domain/usecases/auth/user_fav_songs.dart';
import 'domain/usecases/songs/get_songs.dart';

final sl = GetIt.instance;

Future<void>initializeDependencies()async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());
  sl.registerSingleton<SongFirebaseService>(SongsFirebaseServiceimpl());
  

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<SongsRepository>(SongRepositoryImpl());
  
  sl.registerSingleton<SignUpUsecase>(SignUpUsecase());
  
  sl.registerSingleton<SignUInUsecase>(SignUInUsecase());
  sl.registerSingleton<GetNewSongsUsecases>(GetNewSongsUsecases());
  sl.registerSingleton<GetPlayListUsecases>(GetPlayListUsecases());
  sl.registerSingleton<AddRemoveFavouriteSongsUseCase>(AddRemoveFavouriteSongsUseCase());
  sl.registerSingleton<IsFavouriteSongUsecase>(IsFavouriteSongUsecase());
  sl.registerSingleton<GetProfileUsecase>(GetProfileUsecase());
  sl.registerSingleton<GetUserFavouriteUsecase>(GetUserFavouriteUsecase());
}