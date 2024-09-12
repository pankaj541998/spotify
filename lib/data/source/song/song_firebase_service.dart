
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:spotify_bloc/data/models/songs/songs.dart';
import 'package:spotify_bloc/domain/entities/songs/songs.dart';

abstract class SongFirebaseService{
  Future<Either> getNewSongs();
}


class SongsFirebaseimpl extends SongFirebaseService{
  @override
  Future<Either> getNewSongs() async {
    try {
      List<SongEntity> songs = [];
    final data = await FirebaseFirestore.instance.collection('songs')
    .orderBy('releaseDate',descending: true).limit(3).get();
    for (var element in data.docs) {
      var songsModel = SongModel.fromJson(element.data());
      songs.add(songsModel.toEntity());

    }

    return Right(songs);
      
    } on FirebaseException  catch (e) {
      return Left(e.toString());
      
    }
  }
  
}