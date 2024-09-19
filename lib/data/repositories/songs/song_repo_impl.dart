import 'package:dartz/dartz.dart';
import 'package:spotify_bloc/data/source/song/song_firebase_service.dart';
import 'package:spotify_bloc/domain/repositories/songs/songs.dart';

import '../../../service_locator.dart';

class SongRepositoryImpl extends SongsRepository {
  @override
  Future<Either> getNewsSongs() async {
    return await sl<SongFirebaseService>().getNewSongs();
  }
  
  @override
  Future<Either> getPlayList()async {
    return await sl<SongFirebaseService>().getPlayList();
  }
  
  @override
  Future<Either> addRemoveFavSong(String songId) async{
   return await sl<SongFirebaseService>().addRemoveFavSong(songId);
  }
  
  @override
  Future<bool> isFavouriteSong(String songId) async{
    return await sl<SongFirebaseService>().isFavouriteSong(songId);
  }

}
