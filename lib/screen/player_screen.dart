import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:marquee/marquee.dart';
import 'package:tunesync/service/audio_controller.dart';
import 'package:tunesync/utils/custom_text_style.dart';

import '../model/local_song_model.dart';
import '../widgets/neo_button.dart';
import '../widgets/neo_container.dart';

class PlayerScreen extends StatefulWidget {
  final LocalSongModel song;
  final int index;
   PlayerScreen({super.key , required this.index , required this.song});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final audioController = AudioController();
  bool _isPlaying = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFE0E5EC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ValueListenableBuilder(valueListenable: audioController.currentIndex, builder: (context , currentIndex , _){
              return Column(
                children: [
                  // Header with back button
                  Row(
                    children: [
                      NeoButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                      ),
                      const Spacer(),
                      Text(
                        'Now Playing',
                        style: myTextStyle24()
                      ),
                      const Spacer(),
                      NeoButton(
                        onPressed: () {},
                        child: const Icon(Icons.more_vert, size: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  // Album Art
                  SizedBox(
                    height: size.width * 0.8,
                    width: size.width * 0.8,
                    child: Lottie.asset(
                      "lib/assets/animation/music-new.json",
                      fit: BoxFit.contain, // Ensure animation fits properly
                    ),
                  ),


                  const SizedBox(height: 40),
                  /// --- SONG TITLE --- ///
                  SizedBox(
                    height: 30,
                    child: Marquee(
                      blankSpace: 50,
                      startPadding: 10,
                      velocity: 30,
                      style: myTextStyle18(fontColor: Colors.black45),
                      text: widget.song.title.toString().split('/').last,
                    ),
                  ),
                  SizedBox(height: 6,),
                  Text(
                    widget.song.artist,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: myTextStyle15(),
                  ),
                  // Song Info



                  const SizedBox(height: 20),

                  /// --- Progress Bar --- ///
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: StreamBuilder<Duration>(
                      stream: audioController.audioPlayer.positionStream,
                      builder: (context, snapshot) {
                        final position = snapshot.data ?? Duration.zero;
                        final duration = audioController.audioPlayer.duration ?? Duration.zero;
                        return ProgressBar(
                          progress: position,
                          total: duration,
                          progressBarColor: Colors.greenAccent,
                          baseBarColor: Colors.black26,
                          bufferedBarColor: Colors.black12,
                          thumbColor: Colors.greenAccent,
                          onSeek: (duration) {
                            audioController.audioPlayer.seek(duration);
                          },
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Main Controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      NeoButton(
                        onPressed: () {
                          audioController.previousSong();
                        },
                        child: const Icon(Icons.skip_previous_rounded, size: 30),
                      ),
                      NeoButton(
                        btnBackGroundColor: Colors.greenAccent,
                        onPressed: () {
                          audioController.togglePlayPause();

                          setState(() {
                            _isPlaying = !_isPlaying;
                          });
                        },
                        padding: const EdgeInsets.all(20),
                        isPressed: _isPlaying,
                        child: Icon(
                          _isPlaying ? Icons.play_arrow_rounded : Icons.pause_rounded,
                          size: 40,
                        ),
                      ),
                      NeoButton(
                        onPressed: () {
                          audioController.nextSong();

                        },
                        child: const Icon(Icons.skip_next_rounded, size: 30),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),



                ],
              );
            })
          ),
        ),
      ),
    );
  }
}



