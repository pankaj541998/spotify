import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/songs/get_playlist.dart';
import '../../../service_locator.dart';
import 'get_playlist_state.dart';

class SongPlayListCubit extends Cubit<PlayListState> {
  SongPlayListCubit():super(PlayListLoadingState());

  Future<void> playListSongs() async {
    var returedData = await sl<GetPlayListUsecases>().call();
    // log("returedData of playlist $returedData");
    returedData.fold((l) {
      emit(
        PlayListLoadFailure(message: "Something went wrong, Please try again"),
      );
    }, (data) {
      emit(
        PlayListLoaddedState(songs: data),
      );
    });
  }
}
