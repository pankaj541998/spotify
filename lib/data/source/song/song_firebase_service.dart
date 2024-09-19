import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_bloc/data/models/songs/songs.dart';
import 'package:spotify_bloc/domain/entities/songs/songs.dart';
import 'package:spotify_bloc/domain/usecases/songs/is_fav_song.dart';

import '../../../service_locator.dart';

abstract class SongFirebaseService {
  Future<Either> getNewSongs();
  Future<Either> getPlayList();
  Future<Either> addRemoveFavSong(String songId);
  Future<bool> isFavouriteSong(String songId);
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
        var isFavourite= await sl<IsFavouriteSongUsecase>().call(
          params: element.reference.id
        );

        songsModel.isFavourite = isFavourite;
        songsModel.songId = element.reference.id;
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

      log("returedData of playlist ${data.docs}");
      for (var element in data.docs) {
        var songsModel = SongModel.fromJson(element.data());
        var isFavourite= await sl<IsFavouriteSongUsecase>().call(
          params: element.reference.id
        );

        songsModel.isFavourite = isFavourite;
        songsModel.songId = element.reference.id;
        songs.add(songsModel.toEntity());
      }
      log("returedData of playlist $songs");

      return Right(songs);
    } on FirebaseException catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> addRemoveFavSong(String songId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      late bool isFavourite;

      var user = firebaseAuth.currentUser;
      String uid = user!.uid;
      QuerySnapshot FavouriteSongs = await firebaseFirestore
          .collection("Users")
          .doc(uid)
          .collection('Favourites')
          .where('songId', isEqualTo: songId)
          .get();

      if (FavouriteSongs.docs.isNotEmpty) {
        await FavouriteSongs.docs.first.reference.delete();
        isFavourite = false;
      } else {
        await firebaseFirestore
            .collection("Users")
            .doc(uid)
            .collection('Favourites')
            .add(
          {
            'songId': songId,
            'addedDate': Timestamp.now(),
          },
        );
        isFavourite = true;
      }

      return Right(isFavourite);
    } catch (e) {
      return const Left("Something went wrong, please try again");
    }
  }
  
  @override
  Future<bool> isFavouriteSong(String songId) async{
    
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = firebaseAuth.currentUser;
      String uid = user!.uid;
      QuerySnapshot FavouriteSongs = await firebaseFirestore
          .collection("Users")
          .doc(uid)
          .collection('Favourites')
          .where('songId', isEqualTo: songId)
          .get();

      if (FavouriteSongs.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
