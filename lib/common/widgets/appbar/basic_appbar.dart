import 'package:flutter/material.dart';
import 'package:spotify_bloc/common/helpers/is_dark_mode.dart';

import '../../../core/configs/theme/app_colors.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title ;
  final bool? hideBack;
  final List<Widget>? action;
  final Color? appbafColour;
  const BasicAppBar({super.key, this.title,this.hideBack=false,this.action,this.appbafColour});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appbafColour ??Colors.transparent,
      elevation: 0,
      actions:action,
      title: title?? const Text(""),
      centerTitle: true,
      leading: hideBack!?null:IconButton(
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
