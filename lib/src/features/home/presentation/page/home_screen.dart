import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/src/core/constants/color/color_const.dart';
import 'package:spotify/src/core/constants/vectors/app_vectors.dart';
import 'package:spotify/src/core/extensions/check_theme.dart';
import 'package:spotify/src/core/extensions/get_mediaquery_heigh_width.dart';
import 'package:spotify/src/core/extensions/get_text_theme.dart';
import 'package:spotify/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:spotify/src/features/home/presentation/bloc/home_event.dart';
import 'package:spotify/src/features/home/presentation/widget/app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    BlocProvider.of<HomeBloc>(context).add(GetAllSongs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 28),
        child: Column(
          children: [
            Container(
              height: context.getHeight * 0.16,
              margin: const EdgeInsets.only(right: 28),
              decoration: BoxDecoration(
                color: ColorConst.instance.lightGreen,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  FittedBox(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 10),
                      width: context.getWidth * 0.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('New Album', style: context.textMedium),
                          Text('Happier Than Ever', style: context.textMedium!.copyWith(fontSize: 24)),
                          Text('Billie Eilish', style: context.textMedium),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 41),
            TabBar(
              controller: _tabController,
              dividerColor: Colors.transparent,
              labelColor: context.isDark ? ColorConst.instance.white : ColorConst.instance.black,
              indicatorColor: ColorConst.instance.lightGreen,
              unselectedLabelColor: ColorConst.instance.grey.withOpacity(0.8),
              tabs: const [
                Tab(text: 'News'),
                Tab(text: 'Video'),
                Tab(text: 'Artist'),
                Tab(text: 'Podcast'),
              ],
            ),
            const SizedBox(height: 28),
            SizedBox(
              height: 240,
              width: double.infinity,
              child: ListView.separated(
                itemCount: 5,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const SizedBox(width: 14),
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 185,
                        width: 147,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                            image: AssetImage(AppVectors.instance.backgroundImage1),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        'Bad Guy',
                        style: context.textMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        'Billie Eilish',
                        style: context.textMedium,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
