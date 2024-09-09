import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_bloc/common/widgets/appbar/basic_appbar.dart';
import 'package:spotify_bloc/core/configs/assets/app_images.dart';
import 'package:spotify_bloc/core/configs/assets/app_vectors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BasicAppBar(
          hideBack: true,
          title: SvgPicture.asset(
            AppVectors.logo,
            width: 40,
            height: 40,
          ),
        ),
        body: Column(
          children: [],
        ));
  }

  Widget homeTopCard() {
    return Center(
      child: Stack(
        children: [
          SvgPicture.asset(AppVectors.homeTopCard),
          Image.asset(AppImages.homeArtist)
        ],
      ),
    );
  }
}
