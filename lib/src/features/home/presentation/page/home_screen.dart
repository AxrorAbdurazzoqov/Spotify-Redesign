import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/src/core/constants/color/color_const.dart';
import 'package:spotify/src/core/constants/vectors/app_vectors.dart';
import 'package:spotify/src/core/extensions/check_theme.dart';
import 'package:spotify/src/core/extensions/get_mediaquery_heigh_width.dart';
import 'package:spotify/src/core/extensions/get_text_theme.dart';
import 'package:spotify/src/features/detail/presentation/page/play_screen.dart';
import 'package:spotify/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:spotify/src/features/home/presentation/bloc/home_event.dart';
import 'package:spotify/src/features/home/presentation/bloc/home_state.dart';
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
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.status == HomeStatus.success) {
              return Column(
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
                                Text('Popular', style: context.textMedium),
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
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    dividerColor: Colors.transparent,
                    labelColor: context.isDark ? ColorConst.instance.white : ColorConst.instance.black,
                    indicatorColor: ColorConst.instance.lightGreen,
                    unselectedLabelColor: ColorConst.instance.grey.withOpacity(0.8),
                    tabs: const [
                      Tab(text: 'Artist'),
                      Tab(text: 'Albums'),
                      Tab(text: 'Podcast'),
                      Tab(text: 'Genre'),
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
                        return FittedBox(
                          child: SizedBox(
                            width: 147,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: 185,
                                      margin: const EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            state.songs[index].cover,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 15,
                                      right: 5,
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => PlayScreen(model: state.songs[index]),
                                            ),
                                          );
                                        },
                                        icon: CircleAvatar(
                                          backgroundColor: ColorConst.instance.black.withOpacity(0.5),
                                          child: SvgPicture.asset(
                                            height: 22,
                                            AppVectors.instance.play,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  state.songs[index].title,
                                  style: context.textMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  state.songs[index].author,
                                  style: context.textMedium,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
          },
        ),
      ),
    );
  }
}
