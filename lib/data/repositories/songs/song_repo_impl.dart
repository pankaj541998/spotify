import 'package:dartz/dartz.dart';
import 'package:spotify_bloc/data/source/song/song_firebase_service.dart';
import 'package:spotify_bloc/domain/repositories/songs/songs.dart';

import '../../../service_locator.dart';

class SongRepositoryImpl extends SongsRepository{
  @override
  Future<Either> getNewSongs()async{

    return await sl<SongFirebaseService>().getNewSongs();


    // try {

      
    // } catch (e) {
      
    // }
  }
  
}