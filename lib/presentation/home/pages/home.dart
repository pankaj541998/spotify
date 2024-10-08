import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_bloc/common/helpers/is_dark_mode.dart';
import 'package:spotify_bloc/common/widgets/appbar/basic_appbar.dart';
import 'package:spotify_bloc/core/configs/assets/app_images.dart';
import 'package:spotify_bloc/core/configs/assets/app_vectors.dart';
import 'package:spotify_bloc/core/configs/theme/app_colors.dart';
import 'package:spotify_bloc/presentation/profile/pages/profile.dart';

import '../widgets/get_playlist.dart';
import '../widgets/news_songs.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        hideBack: true,
        action: [IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const Profile(),));
        }, icon: const Icon(Icons.person))],
        title: SvgPicture.asset(
          AppVectors.logo,
          width: 40,
          height: 40,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _homeTopCard(),
            const SizedBox(height: 20),
            _tabbar(),
            const SizedBox(height: 20),
            SizedBox(
              height: 260,
              child: TabBarView(
                controller: _tabController,
                children: const [
                  NewsSongs(),
                  SizedBox(),
                  SizedBox(),
                  SizedBox(),
                ],
              ),
            ),
            const GetPlayList()
          ],
        ),
      ),
    );
  }

  Widget _homeTopCard() {
    return Center(
      child: SizedBox(
        height: 140,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(
                AppVectors.homeTopCard,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 80),
                child: Image.asset(AppImages.homeArtist),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _tabbar() {
    return TabBar(
      controller: _tabController,
      labelColor: context.isDarkMode ? Colors.white : Colors.black,
      indicatorColor: AppColors.primary,
      dividerHeight: 0,
      // padding:const EdgeInsets.symmetric(vertical: 30,horizontal: 30),
      indicatorSize: TabBarIndicatorSize.label,
      tabs: const [
        Text(
          "News",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Text(
          "Video",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Text(
          "Artists",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Text(
          "Podcast",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
