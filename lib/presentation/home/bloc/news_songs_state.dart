import 'package:spotify_bloc/domain/entities/songs/songs.dart';

abstract class NewsSongsState {}

class NewsSongsLoading extends NewsSongsState {}

class NewsSongsLoadded extends NewsSongsState {
  final List<SongEntity> songs;

  NewsSongsLoadded({required this.songs});
}

class NewsSongsLoadFailure extends NewsSongsState {
  final String message;

  NewsSongsLoadFailure({required this.message});
}
