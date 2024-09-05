import 'package:flutter/material.dart';
import 'package:spotify_bloc/common/helpers/is_dark_mode.dart';

import '../../../core/configs/theme/app_colors.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title ;
  const BasicAppBar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: title?? const Text(""),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: context.isDarkMode? AppColors.lightBackground.withOpacity(0.03):AppColors.darkBackground.withOpacity(0.03),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back_ios_new,size: 16,),
        ),
      ),
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
