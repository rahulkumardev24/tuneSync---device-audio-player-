import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tunesync/service/audio_controller.dart';
import 'package:tunesync/utils/custom_text_style.dart';
import 'package:tunesync/widgets/neo_button.dart';
import 'package:tunesync/widgets/song_list_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final audioController = AudioController();
  bool _hasPermission = false;

  @override
  void initState() {
    super.initState();
    _checkAndRequestPermission();
  }

  /// check audio permission
  Future<void> _checkAndRequestPermission() async {
    final permission = await Permission.audio.status;
    if (permission.isGranted) {
      setState(() => _hasPermission = true);
      await audioController.loadSongs();
    } else {
      final result = await Permission.audio.request();
      setState(() => _hasPermission = result.isGranted);
      if (result.isGranted) {
        await audioController.loadSongs();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    backgroundColor:
    const Color(0xFFE0E5EC);
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Text(
                  "Tune",
                  style: myTextStyle24(
                    fontWeight: FontWeight.bold,
                    fontColor: Colors.black,
                  ),
                ),
              ),
              WidgetSpan(
                child: Text(
                  "Sync",
                  style: myTextStyle24(
                   fontWeight: FontWeight.w900,
                    fontColor: Colors.greenAccent,
                  ),
                ),
              ),
            ],
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: NeoButton(child: Center(child: Icon(Icons.person)), onPressed: (){}),
        ),
        toolbarHeight: 80,
        actions: [
          NeoButton(child: Icon(Icons.favorite_border), onPressed: (){}) ,
          SizedBox(width: 16,),
          NeoButton(child: Icon(Icons.settings), onPressed: (){}) ,
          SizedBox(width: 12,)
        ],
      ),

      body: ValueListenableBuilder(
        valueListenable: audioController.songs,
        builder: (context, songs, child) {
          if (songs.isEmpty) {
            return Center(child: Text("Song list is empty"));
          }
          return ListView.builder(
            itemCount: songs.length,
            itemBuilder: (context, index) {
              return SongListItem(song: songs[index], index: index);
            },
          );
        },
      ),
    );
  }
}
