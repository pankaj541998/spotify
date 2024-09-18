import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:spotify_bloc/data/models/songs/songs.dart';
import 'package:spotify_bloc/domain/entities/songs/songs.dart';

abstract class SongFirebaseService {
  Future<Either> getNewSongs();
  Future<Either> getPlayList();
}

class SongsFirebaseServiceimpl extends SongFirebaseService {
  @override
  Future<Either> getNewSongs() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection('songs')
          .orderBy('date', descending: true)
          .limit(3)
          .get();
      for (var element in data.docs) {
        var songsModel = SongModel.fromJson(element.data());
        songs.add(songsModel.toEntity());
      }

      return Right(songs);
    } on FirebaseException catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> getPlayList() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection('songs')
          .orderBy('date', descending: true)
          .get();
      for (var element in data.docs) {
        var songsModel = SongModel.fromJson(element.data());
        songs.add(songsModel.toEntity());
      }

      return Right(songs);
    } on FirebaseException catch (e) {
      return Left(e.toString());
    }
  }
}
