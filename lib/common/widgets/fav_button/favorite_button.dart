import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_bloc/common/bloc/favorite_button/favorite_button_cubit.dart';
import 'package:spotify_bloc/common/bloc/favorite_button/favorite_button_state.dart';
import 'package:spotify_bloc/domain/entities/songs/songs.dart';

import '../../../core/configs/theme/app_colors.dart';

class FavoriteButton extends StatelessWidget {
  final SongEntity songEntity;
  const FavoriteButton({super.key, required this.songEntity});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteButtonCubit(),
      child: BlocBuilder<FavoriteButtonCubit, FavoriteButtonState>(
        builder: (context, state) {
          if (state is FavoriteButtonInitalState) {
            return  GestureDetector(
                  onTap: (){
                    context.read<FavoriteButtonCubit>().favButtonUpdated(songEntity.songId);
                  },
                  child: Icon(
                     songEntity.isFavorite? Icons.favorite:Icons.favorite_outline_rounded,
                      color: songEntity.isFavorite?AppColors.primary:AppColors.darkGrey,
                    ),
                );
          } else if (state is FavoriteButtonUpdatedState) {
            return state.isFavorite
                ? GestureDetector(
                  onTap: (){
                    context.read<FavoriteButtonCubit>().favButtonUpdated(songEntity.songId);
                  },
                  child: const Icon(
                      Icons.favorite,
                      color: AppColors.primary,
                    ),
                )
                : GestureDetector(
                  onTap: (){
                    context.read<FavoriteButtonCubit>().favButtonUpdated(songEntity.songId);
                  },
                  child: const Icon(
                      Icons.favorite_outline_rounded,
                      color: AppColors.darkGrey,
                    ),
                );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
