import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/src/core/constants/color/color_const.dart';
import 'package:spotify/src/core/constants/vectors/app_vectors.dart';
import 'package:spotify/src/core/extensions/get_mediaquery_heigh_width.dart';
import 'package:spotify/src/features/navbar/presentation/bloc/navbar_bloc.dart';
import 'package:spotify/src/features/navbar/presentation/bloc/navbar_event.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: context.getWidth * 0.2,
      centerTitle: true,
      leading: IconButton(
        iconSize: 32,
        onPressed: () {
          context.read<NavbarBloc>().add(OnNavbarIndexChangedEvent(index: 1));
        },
        icon: Icon(
          CupertinoIcons.search,
          color: ColorConst.instance.grey,
        ),
      ),
      title: SvgPicture.asset(AppVectors.instance.spotifyLogo, height: 42),
      actions: [
        IconButton(
          iconSize: 32,
          onPressed: () {
            // showModalBottomSheet(
            //   context: context,
            //   builder: (context) {
            //     return const CustomModalBottomSheet();
            //   },
            // );
          },
          icon: Icon(
            Icons.more_vert,
            color: ColorConst.instance.grey,
          ),
        ),
        const SizedBox(width: 20),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
