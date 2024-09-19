import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_bloc/domain/usecases/songs/add_remove_fav_song.dart';
import 'package:spotify_bloc/service_locator.dart';

import 'favorite_button_state.dart';

class FavouriteButtonCubit extends Cubit<FavouriteButtonState> {
  FavouriteButtonCubit() : super(FavouriteButtonInitalState());

  Future<void> favButtonUpdated(String songId) async {
    var result = await sl<AddRemoveFavouriteSongsUseCase>().call(params: songId);

    result.fold(
      (l) {

      },
      (isFavourite) {
        emit(FavouriteButtonUpdatedState(isFavourite: isFavourite));
      },
    );
  }
}
