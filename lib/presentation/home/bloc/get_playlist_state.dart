import 'package:spotify_bloc/domain/entities/songs/songs.dart';

abstract class PlayListState{}

class PlayListLoadingState extends PlayListState{}
class PlayListLoaddedState extends PlayListState{
  final List<SongEntity> songs;

  PlayListLoaddedState({required this.songs}); 
}
class PlayListLoadFailure extends PlayListState{
  final String message;

  PlayListLoadFailure({required this.message});
}
