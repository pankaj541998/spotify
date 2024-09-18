import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify_bloc/domain/entities/songs/songs.dart';

class SongModel {
  String? title;
  String? artist;
  double? duration;
  Timestamp? releaseDate;

  SongModel({
    required this.title,
    required this.artist,
    required this.duration,
    required this.releaseDate,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      title: json["title"],
      artist: json["artist-name"],
      duration: json["duration"],
      releaseDate: json["date"],
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
