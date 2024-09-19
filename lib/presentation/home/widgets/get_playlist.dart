import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_bloc/common/helpers/is_dark_mode.dart';
import 'package:spotify_bloc/common/widgets/fav_button/favorite_button.dart';
import 'package:spotify_bloc/domain/entities/songs/songs.dart';
import 'package:spotify_bloc/presentation/home/bloc/get_playlist_cubit.dart';
import 'package:spotify_bloc/presentation/home/bloc/get_playlist_state.dart';

import '../../../core/configs/theme/app_colors.dart';
import '../../../core/extension/text_capitalize.dart';
import '../../song_player/pages/song_plyer.dart';

class GetPlayList extends StatelessWidget {
  const GetPlayList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SongPlayListCubit()..playListSongs(),
      child: BlocBuilder<SongPlayListCubit, PlayListState>(
        builder: (context, state) {
          if (state is PlayListLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PlayListLoaddedState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Playlist",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "See More",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _songs(state.songs),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _songs(List<SongEntity> songs) {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SongPlayer(
                            songEntity: songs[index],
                          ),
                        ),
                      );
                    },
                    child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.isDarkMode
                                ? AppColors.darkGrey
                                : const Color(0xffe6e6e6)),
                        child: Icon(
                          Icons.play_arrow_rounded,
                          color: context.isDarkMode
                              ? AppColors.lightBackground.withOpacity(0.8)
                              : AppColors.darkGrey.withOpacity(0.8),
                        )),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        renameTitle(
                          songs[index].title,
                        ),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        renameTitle(
                          songs[index].artist,
                        ),
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    songs[index].duration.toString().replaceAll(".", ":"),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 10),
                  FavoriteButton(songEntity: songs[index]),
                ],
              )
            ],
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 20);
        },
        itemCount: songs.length);
  }
}
