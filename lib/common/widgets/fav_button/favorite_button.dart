import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:spotify_bloc/domain/entities/songs/songs.dart';

import '../../../core/configs/theme/app_colors.dart';
import '../../bloc/favorite_button/favorite_button_cubit.dart';
import '../../bloc/favorite_button/favorite_button_state.dart';

class FavouriteButton extends StatelessWidget {
  final SongEntity songEntity;
  final Function? function;
  const FavouriteButton({super.key, required this.songEntity,  this.function});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouriteButtonCubit(),
      child: BlocBuilder<FavouriteButtonCubit, FavouriteButtonState>(
        builder: (context, state) {
          if (state is FavouriteButtonInitalState) {
            return  GestureDetector(
                  onTap: () async{
                   await context.read<FavouriteButtonCubit>().favButtonUpdated(songEntity.songId);
                    if(function != null){
                      function!();
                    }
                  },
                  child: Icon(
                     songEntity.isFavourite? Icons.favorite:Icons.favorite_outline_rounded,
                      color: songEntity.isFavourite?AppColors.primary:AppColors.darkGrey,
                    ),
                );
          } else if (state is FavouriteButtonUpdatedState) {
            return state.isFavourite
                ? GestureDetector(
                  onTap: (){
                    context.read<FavouriteButtonCubit>().favButtonUpdated(songEntity.songId);
                  },
                  child:  const Icon(
                      Icons.favorite,
                      color: AppColors.primary,
                    ),
                )
                : GestureDetector(
                  onTap: (){
                    context.read<FavouriteButtonCubit>().favButtonUpdated(songEntity.songId);
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
