import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_bloc/common/widgets/appbar/basic_appbar.dart';
import 'package:spotify_bloc/common/widgets/fav_button/favorite_button.dart';
import 'package:spotify_bloc/domain/entities/songs/songs.dart';
import 'package:spotify_bloc/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:spotify_bloc/presentation/song_player/bloc/song_player_state.dart';

import '../../../core/configs/constant/app_urls.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../core/extension/text_capitalize.dart';

class SongPlayer extends StatelessWidget {
  final SongEntity songEntity;
  const SongPlayer({super.key, required this.songEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BasicAppBar(
          title: const Text(
            "Now Playing",
            style: TextStyle(fontSize: 18),
          ),
          action: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert_rounded,
              ),
            )
          ],
        ),
        body: BlocProvider(
          create: (context) => SongPlayerCubit()
            ..songLoad(
                '${AppURLs.songFirestorage}${songEntity.title}.mp3?${AppURLs.mediaAlt}'),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _songCover(context),
                  const SizedBox(height: 20),
                  _songTitle(),
                  const SizedBox(height: 30),
                  _songPlayer(context),
                ],
              ),
            ),
          ),
        ));
  }

  _songCover(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
            image: NetworkImage(
                '${AppURLs.coverFirestorage}${songEntity.title}.jpg?${AppURLs.mediaAlt}'),
            fit: BoxFit.cover),
      ),
    );
  }

  _songTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              renameTitle(
                songEntity.title,
              ),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              renameTitle(
                songEntity.artist,
              ),
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            )
          ],
        ),
        FavouriteButton(songEntity: songEntity)
      ],
    );
  }

  _songPlayer(BuildContext context) {
    return BlocBuilder<SongPlayerCubit, SongPLayerState>(
      builder: (context, state) {
      var readContext = context.read<SongPlayerCubit>(); 
        if (state is SongPlayerLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SongPlayerLoadded) {
          return Column(
            children: [
              Slider(
                value: readContext
                    .songPosition
                    .inSeconds
                    .toDouble(),
                min: 0,
                max: readContext
                    .songDuration
                    .inSeconds
                    .toDouble(),
                onChanged: (v) {

                  readContext
                    .songPosition
                    .inSeconds
                    .toDouble();

                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formateDuration(
                      readContext.songPosition,
                    ),
                  ),
                  Text(
                    formateDuration(
                      readContext.songDuration,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: readContext.songPlayNPause,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary
                  ),
                  child: readContext.audioPlayer.playing ?const Icon(Icons.pause):const Icon(Icons.play_arrow_rounded),
                ),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }

  String formateDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    return '${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}';
  }
}
