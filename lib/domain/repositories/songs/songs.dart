import 'package:dartz/dartz.dart';

abstract class SongsRepository{
  Future<Either> getNewsSongs();
  Future<Either> getPlayList();
  Future<Either> addRemoveFavSong(String songId);
  Future<bool> isFavoriteSong(String songId);
}