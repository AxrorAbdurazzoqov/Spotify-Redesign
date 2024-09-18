import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/src/core/constants/color/color_const.dart';
import 'package:spotify/src/core/constants/vectors/app_vectors.dart';
import 'package:spotify/src/core/extensions/get_mediaquery_heigh_width.dart';
import 'package:spotify/src/core/extensions/get_text_theme.dart';
import 'package:spotify/src/features/home/data/model/song_model.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key, required this.model});

  final SongModel model;

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  final player = AudioPlayer();
  late final StreamSubscription currentSubscription;
  Duration position = const Duration(seconds: 0);
  late Duration duration;

  @override
  void initState() {
    super.initState();

    player.setSource(UrlSource(widget.model.song)).then((_) async {
      player.play(UrlSource(widget.model.song));
      duration = await player.getDuration() ?? const Duration(seconds: 0);
    });
    initStreams();
  }

  void initStreams() {
    currentSubscription = player.onPositionChanged.listen((val) {
      setState(() {
        position = val;
      });
    });
  }

  @override
  void dispose() {
    player.dispose();
    currentSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leadingWidth: 70,
        leading: IconButton(
          padding: const EdgeInsets.only(left: 32),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: CircleAvatar(
            backgroundColor: ColorConst.instance.grey.withOpacity(0.5),
            child: const Icon(
              Icons.chevron_left_outlined,
            ),
          ),
        ),
        title: Text(
          widget.model.author,
          style: context.textLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Container(
              height: context.getHeight * 0.43,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  image: NetworkImage(widget.model.cover),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text.rich(
                        TextSpan(
                          text: "${widget.model.author}\n",
                          style: context.textLarge,
                          children: [
                            TextSpan(
                              text: widget.model.title,
                              style: context.textMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(AppVectors.instance.liked),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: Slider(
                max: duration.inSeconds.toDouble(),
                value: position.inSeconds.toDouble(),
                onChanged: (val) {
                  player.seek(Duration(seconds: val.toInt()));
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  durationFormatter(position.inSeconds),
                  style: context.textMedium,
                ),
                Text(
                  "-${durationFormatter(duration.inSeconds - position.inSeconds)}",
                  style: context.textMedium,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(AppVectors.instance.repeat),
                ),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(AppVectors.instance.previous),
                ),
                IconButton(
                  onPressed: () {
                    if (currentSubscription.isPaused) {
                      player.resume();
                      currentSubscription.resume();
                    } else {
                      player.pause();
                      currentSubscription.pause();
                    }
                  },
                  icon: CircleAvatar(
                    backgroundColor: ColorConst.instance.lightGreen,
                    radius: 30,
                    child: currentSubscription.isPaused
                        ? SvgPicture.asset(AppVectors.instance.play)
                        : Icon(
                            Icons.pause,
                            size: 36,
                            color: ColorConst.instance.white,
                          ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(AppVectors.instance.next),
                ),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(AppVectors.instance.shuffle),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

String durationFormatter(int seconds) {
  int minute = seconds ~/ 60;
  int hour = minute ~/ 60;
  seconds = seconds % 60;
  minute = minute % 60;

  if (hour > 0) {
    return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  } else if (minute > 0) {
    return "${minute.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  } else {
    return "00:${seconds.toString().padLeft(2, '0')}";
  }
}
