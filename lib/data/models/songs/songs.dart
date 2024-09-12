import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify_bloc/domain/entities/songs/songs.dart';

class SongModel {
  String? title;
  String? artist;
  int? duration;
  Timestamp? releaseDate;

  SongModel({
    required this.title,
    required this.artist,
    required this.duration,
    required this.releaseDate,
  });

  // SongModel.fromJson(Map<String, dynamic> json) {
  //   title=json["title"];
  //   artist=json[""];
  //   duration=json[""];
  //   releaseDate=json[""];
  // }

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      title: json["title"],
      artist: json["artist"],
      duration: json["duration"],
      releaseDate: json["releaseDate"],
    );
  }
}

extension SongModelX on SongModel {
  SongEntity toEntity() {
    return SongEntity(
      title: title!,
      artist: artist!,
      duration: duration!,
      releaseDate: releaseDate!,
    );
  }
}
