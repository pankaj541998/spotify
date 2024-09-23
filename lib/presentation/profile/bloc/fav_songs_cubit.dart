import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_bloc/domain/entities/songs/songs.dart';
import 'package:spotify_bloc/domain/usecases/auth/user_fav_songs.dart';
import 'package:spotify_bloc/presentation/profile/bloc/fav_songs_state.dart';
import 'package:spotify_bloc/service_locator.dart';

class FavSongCubit extends Cubit<FavSongState> {
  FavSongCubit() : super(FavSongLoading());

  List<SongEntity> favSongs = [];

  Future<void> getFavSongList() async {
    var result = await sl<GetUserFavouriteUsecase>().call();

    result.fold((l) {
      emit(FavSongFailure());
    }, (r) {
      favSongs = r;
      emit(FavSongLoadded(favSongs: favSongs));
    });
  }

  void removeFavSongs(int index) {
    favSongs.removeAt(index);
    emit(
      FavSongLoadded(favSongs: favSongs),
    );
  }
}
