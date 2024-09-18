import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_bloc/common/helpers/is_dark_mode.dart';
import 'package:spotify_bloc/core/configs/constant/app_urls.dart';
import 'package:spotify_bloc/core/configs/theme/app_colors.dart';
import 'package:spotify_bloc/core/extension/text_capitalize.dart';
import 'package:spotify_bloc/domain/entities/songs/songs.dart';
import 'package:spotify_bloc/presentation/home/bloc/news_songs_cubit.dart';
import 'package:spotify_bloc/presentation/home/bloc/news_songs_state.dart';

class NewsSongs extends StatelessWidget {
  const NewsSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewsSongsCubit()..getNewsSongs(),
      child: SizedBox(
        height: 200,
        child: BlocBuilder<NewsSongsCubit, NewsSongsState>(
          builder: (context, state) {
            if (state is NewsSongsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is NewsSongsLoadded) {
              log("state.songs ${state.songs}");
              return _songs(state.songs);
            }
            if (state is NewsSongsLoadFailure) {
              return Text(state.message);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  _songs(List<SongEntity> songs) {
    renameTitle(text) {
      var texted = text.replaceAll('-', ' ');
      return texted[0].toUpperCase() + texted.substring(1).toLowerCase();
    }

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: songs.length,
      separatorBuilder: (context, index) {
        return const SizedBox(width: 14);
      },
      itemBuilder: (context, index) {
        return SizedBox(
          width: 160,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          '${AppURLs.coverFirestorage}${songs[index].title}.jpg?${AppURLs.mediaAlt}'),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 40,
                      height: 40,
                      transform: Matrix4.translationValues(10, 10, 0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,color:context.isDarkMode? AppColors.darkGrey:const Color(0xffe6e6e6)
                      ),
                      child:  IconButton(
                        onPressed: (){},
                        icon: const Icon(Icons.play_arrow_rounded),
                        color: context.isDarkMode? AppColors.lightBackground.withOpacity(0.8):AppColors.darkGrey.withOpacity(0.8),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                renameTitle(songs[index].title),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                songs[index].artist,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
