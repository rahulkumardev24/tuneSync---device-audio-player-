import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:marquee/marquee.dart';
import 'package:tunesync/utils/custom_text_style.dart';
import 'package:tunesync/widgets/neo_button.dart';
import '../screen/player_screen.dart';
import '../service/audio_controller.dart';

class BottomPlayer extends StatelessWidget {
  const BottomPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final audioController = AudioController();
    return ValueListenableBuilder(
      valueListenable: audioController.currentIndex,
      builder: (context, currentIndex, _) {
        final currentSong = audioController.currentSong;
        if (currentSong == null) return const SizedBox.shrink();
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) =>
                        PlayerScreen(song: currentSong, index: currentIndex),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.greenAccent.shade200,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(21),
                topLeft: Radius.circular(21),
              ),
              boxShadow: [
                const BoxShadow(
                  color: Color(0xFFA3B1C6),
                  offset: Offset(8, 8),
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
                const BoxShadow(
                  color: Colors.white,
                  offset: Offset(-8, -8),
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0 , vertical: 4),
                child: SizedBox(
                height: 20,
                child: Marquee(
                  blankSpace: 50,
                  startPadding: 30,
                  velocity: 10,
                  style: myTextStyle15(),
                  text:currentSong.title.toString().split('/').last,
                ),
                            ),
              ),
                StreamBuilder<Duration>(
                  stream: audioController.audioPlayer.positionStream,
                  builder: (context, snapshot) {
                    final position = snapshot.data ?? Duration.zero;
                    final duration = audioController.audioPlayer.duration ?? Duration.zero;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),

                      /// --- progress bar --- ///
                      child: ProgressBar(
                        progress: position,
                        total: duration,
                        progressBarColor: Color(0xFF4A5668),
                        baseBarColor: Colors.black26,
                        bufferedBarColor: Colors.black12,
                        thumbColor: Color(0xFF4A5668),
                        barHeight: 3,
                        thumbRadius: 6,
                        timeLabelLocation: TimeLabelLocation.none,
                        onSeek: (duration) {
                          audioController.audioPlayer.seek(duration);
                        },
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                  SizedBox(
                    child: Lottie.asset(
                      height: 60,
                      width: 60,
                      "lib/assets/animation/music.json",
                      fit: BoxFit.cover, // Ensure animation fits properly
                    ),
                  ),
                      const SizedBox(width: 12),
                      Expanded(child: SizedBox()),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          NeoButton(
                            blureFirsColor: Colors.white54,
                            blureSecondColor:Colors.white54 ,
                            btnBackGroundColor: Colors.greenAccent.shade200,
                            onPressed: audioController.previousSong,
                            child: Icon(Icons.skip_previous_rounded),
                          ),
                          SizedBox(width: 16,),
                          StreamBuilder<PlayerState>(
                            stream:
                                audioController.audioPlayer.playerStateStream,
                            builder: (context, snapshot) {
                              final playerState = snapshot.data;
                              final processingState =
                                  playerState?.processingState;
                              final playing = playerState?.playing;

                              if (processingState == ProcessingState.loading ||
                                  processingState ==
                                      ProcessingState.buffering) {
                                return Container(
                                  margin: const EdgeInsets.all(8.0),
                                  width: 32.0,
                                  height: 32.0,
                                  child: const CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.greenAccent,
                                    ),
                                  ),
                                );
                              }
                              return NeoButton(
                                blureFirsColor: Colors.white38,
                                blureSecondColor:Colors.white38 ,
                                btnBackGroundColor: Colors.white,

                                onPressed: audioController.togglePlayPause,
                                child: Icon(
                                  playing == true
                                      ? Icons.pause_rounded
                                      : Icons.play_arrow_rounded,
                                  color: playing == true ? Colors.greenAccent : Colors.black,
                                ),
                              );
                            },
                          ),

                          SizedBox(width: 16,),
                          NeoButton(
                            blureFirsColor: Colors.white54,
                            blureSecondColor:Colors.white54 ,
                            btnBackGroundColor: Colors.greenAccent.shade200,
                            // btnBackGroundColor: Colors.white,
                            onPressed: audioController.nextSong, child: const Icon(Icons.skip_next_rounded),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
