import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/src/core/constants/color/color_const.dart';
import 'package:spotify/src/core/constants/vectors/app_vectors.dart';
import 'package:spotify/src/core/extensions/check_theme.dart';
import 'package:spotify/src/core/extensions/get_mediaquery_heigh_width.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: context.getWidth * 0.2,
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 35),
        child: CircleAvatar(
          backgroundColor: context.isDark ? ColorConst.instance.grey.withOpacity(0.5) : ColorConst.instance.grey.withOpacity(0.2),
          child: IconButton(
            iconSize: 25,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              CupertinoIcons.left_chevron,
              color: context.isDark ? ColorConst.instance.white : ColorConst.instance.black,
            ),
          ),
        ),
      ),
      title: SvgPicture.asset(AppVectors.instance.spotifyLogo, height: 42),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}