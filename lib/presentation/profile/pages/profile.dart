import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_bloc/common/helpers/is_dark_mode.dart';
import 'package:spotify_bloc/common/widgets/appbar/basic_appbar.dart';
import 'package:spotify_bloc/core/configs/theme/app_colors.dart';
import 'package:spotify_bloc/presentation/profile/bloc/fav_songs_cubit.dart';
import 'package:spotify_bloc/presentation/profile/bloc/fav_songs_state.dart';
import 'package:spotify_bloc/presentation/profile/bloc/profie_cubit.dart';
import 'package:spotify_bloc/presentation/profile/bloc/profile_state.dart';
import 'package:spotify_bloc/presentation/song_player/pages/song_plyer.dart';

import '../../../common/widgets/fav_button/favorite_button.dart';
import '../../../core/configs/constant/app_urls.dart';
import '../../../core/extension/text_capitalize.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BasicAppBar(
          appbafColour: context.isDarkMode
              ? AppColors.darkGrey
              : AppColors.lightBackground,
          title: const Text(
            'Profile',
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _profileInfo(context),
            const SizedBox(height: 30),
            _userFavsongsList(),
          ],
        ));
  }

  _profileInfo(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getUser(),
      child: Container(
        height: MediaQuery.of(context).size.height / 3.8,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: context.isDarkMode
              ? AppColors.darkGrey
              : AppColors.lightBackground,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          image: const DecorationImage(
            image: NetworkImage(''),
          ),
        ),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProfileLoadded) {
              // log("user profile ${state.userEntity.imageURL}");
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(state.userEntity.imageURL!),
                      ),
                      color: AppColors.darkGrey,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    state.userEntity.email.toString(),
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  Text(state.userEntity.fullName.toString(),
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              );
            } else if (state is ProfileFailure) {
              return const Center(child: Text("Please try again."));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  _userFavsongsList() {
    return BlocProvider(
      create: (context) => FavSongCubit()..getFavSongList(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Favourite Songs",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            BlocBuilder<FavSongCubit, FavSongState>(
              builder: (context, state) {
                if (state is FavSongLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is FavSongLoadded) {
                  return ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SongPlayer(
                                  songEntity: state.favSongs[index],
                                ),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      '${AppURLs.coverFirestorage}${state.favSongs[index].title}.jpg?${AppURLs.mediaAlt}',
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        renameTitle(
                                          state.favSongs[index].title,
                                        ),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        renameTitle(
                                          state.favSongs[index].artist,
                                        ),
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    state.favSongs[index].duration
                                        .toString()
                                        .replaceAll(".", ":"),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(width: 10),
                                  FavouriteButton(
                                    songEntity: state.favSongs[index],
                                    key: UniqueKey(),
                                    function: () {
                                      context
                                          .read<FavSongCubit>()
                                          .removeFavSongs(index);
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 20),
                      itemCount: state.favSongs.length);
                } else if (state is FavSongFailure) {
                  return const Text("Please try again.");
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
