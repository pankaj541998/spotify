import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify_bloc/domain/entities/songs/songs.dart';

class SongModel {
  String? title;
  String? artist;
  dynamic duration;
  Timestamp? releaseDate;
  bool? isFavourite;
  String? songId;

  SongModel({
    required this.title,
    required this.artist,
    required this.duration,
    required this.releaseDate,
    required this.isFavourite,
    required this.songId,
  });

  SongModel.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    artist = json["artist-name"];
    duration = json["duration"];
    releaseDate = json["date"];
  }
}

extension SongModelX on SongModel {
  SongEntity toEntity() {
    return SongEntity(
      title: title!,
      artist: artist!,
      duration: duration,
      releaseDate: releaseDate!,
      isFavourite: isFavourite!,
      songId: songId!,
    );
  }
}
