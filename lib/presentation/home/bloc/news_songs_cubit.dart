import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_bloc/domain/usecases/songs/get_songs.dart';

import '../../../service_locator.dart';
import 'news_songs_state.dart';

class NewsSongsCubit extends Cubit<NewsSongsState> {
  NewsSongsCubit():super(NewsSongsLoading());

  Future<void> getNewsSongs() async {
    var returedData = await sl<GetNewSongsUsecases>().call();
    log("returedData $returedData");
    returedData.fold((l) {
      emit(
        NewsSongsLoadFailure(message: "Something went wrong, Please try again"),
      );
    }, (data) {
      emit(
        NewsSongsLoadded(songs: data),
      );
    });
  }
}
