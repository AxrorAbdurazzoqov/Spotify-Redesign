import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/src/core/constants/color/color_const.dart';
import 'package:spotify/src/core/constants/vectors/app_vectors.dart';
import 'package:spotify/src/core/extensions/check_theme.dart';
import 'package:spotify/src/core/extensions/get_mediaquery_heigh_width.dart';
import 'package:spotify/src/features/navbar/presentation/bloc/navbar_bloc.dart';
import 'package:spotify/src/features/navbar/presentation/bloc/navbar_event.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    NavbarBloc bloc = context.watch<NavbarBloc>();
    return Scaffold(
      body: bloc.state.screens[bloc.state.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bloc.state.currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: context.isDark ? ColorConst.instance.navbarDark : ColorConst.instance.navbarLight,
        onTap: (index) {
          bloc.add(OnNavbarIndexChangedEvent(index: index));
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppVectors.instance.home,
            ),
            activeIcon: CustomActiveIcon(icon: AppVectors.instance.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppVectors.instance.search,
            ),
            activeIcon: CustomActiveIcon(icon: AppVectors.instance.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppVectors.instance.liked,
            ),
            activeIcon: CustomActiveIcon(icon: AppVectors.instance.liked),
            label: "Liked",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppVectors.instance.profile,
            ),
            activeIcon: CustomActiveIcon(icon: AppVectors.instance.profile),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

class CustomActiveIcon extends StatelessWidget {
  const CustomActiveIcon({
    super.key,
    required this.icon,
  });

  final String icon;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SvgPicture.asset(
          icon,
          colorFilter: ColorFilter.mode(ColorConst.instance.lightGreen, BlendMode.srcIn),
        ),
        Positioned(
          bottom: context.getHeight * 0.05,
          left: 0,
          right: 0,
          child: Container(
            height: 3,
            width: 25,
            decoration: BoxDecoration(
              color: ColorConst.instance.lightGreen,
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
            ),
          ),
        ),
      ],
    );
  }
}
