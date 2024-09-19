import 'package:spotify_bloc/domain/entities/songs/songs.dart';

abstract class FavSongState{}

class FavSongLoading extends FavSongState{}
class FavSongLoadded extends FavSongState{
  final List<SongEntity> favSongs;
  FavSongLoadded({required this.favSongs});
}
class FavSongFailure extends FavSongState{}