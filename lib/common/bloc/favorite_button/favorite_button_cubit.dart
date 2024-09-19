import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_bloc/domain/usecases/songs/add_remove_fav_song.dart';
import 'package:spotify_bloc/service_locator.dart';

import 'favorite_button_state.dart';

class FavoriteButtonCubit extends Cubit<FavoriteButtonState> {
  FavoriteButtonCubit() : super(FavoriteButtonInitalState());

  void favButtonUpdated(String songId) async {
    var result = await sl<AddRemoveFavoriteSongsUseCase>().call(params: songId);

    result.fold(
      (l) {

      },
      (isFavorite) {
        emit(FavoriteButtonUpdatedState(isFavorite: isFavorite));
      },
    );
  }
}
