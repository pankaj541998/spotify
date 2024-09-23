import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_bloc/common/widgets/button/basic_app_button.dart';
import 'package:spotify_bloc/core/configs/assets/app_images.dart';
import 'package:spotify_bloc/core/configs/theme/app_colors.dart';
import 'package:spotify_bloc/presentation/choose-mode/page/choose_mode.dart';

import '../../../core/configs/assets/app_vectors.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppImages.introBG), fit: BoxFit.cover),
              ),
            ),
            Container(
              color: Colors.black.withOpacity(0.15),
            ),Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: SvgPicture.asset(AppVectors.logo)),
                    const Spacer(),
                    const Text(
                      "Enjoy listening to music",
                      style: TextStyle(
                          fontSize: 20,
                          color: AppColors.lightBackground,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 21),
                    const Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis enim purus sed phasellus. Cursus ornare id scelerisque aliquam.",
                      style: TextStyle(
                          fontSize: 17,
                          color: AppColors.grey,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    BasicAppButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ChooseMode(),
                            ),
                          );
                        },
                        title: "Get started")
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}
