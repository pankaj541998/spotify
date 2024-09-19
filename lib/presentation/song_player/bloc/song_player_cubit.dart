import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify_bloc/presentation/song_player/bloc/song_player_state.dart';

class SongPlayerCubit extends Cubit<SongPLayerState> {
  AudioPlayer audioPlayer = AudioPlayer();
  Duration songPosition = Duration.zero;
  Duration songDuration = Duration.zero;

  SongPlayerCubit() : super(SongPlayerLoading()) {
    audioPlayer.positionStream.listen((position) {
      songPosition = position;
      songPlayerUpdate();
    });

    audioPlayer.durationStream.listen((duration) {
      songDuration = duration!;
    });
  }

  void songPlayerUpdate() {
    emit(SongPlayerLoadded());
  }

  Future<void> songLoad(String url) async {
    try {
      await audioPlayer.setUrl(url);
      emit(SongPlayerLoadded());
    } catch (e) {
      emit(SongPlayerLoadingFailure());
    }
  }

  void songPlayNPause() {
    if (audioPlayer.playing) {
      audioPlayer.pause();
    } else {
      audioPlayer.play();
    }
    emit(SongPlayerLoadded());
  }

  @override
  Future<void> close(){
    audioPlayer.dispose();
    return super.close();
  }
}
