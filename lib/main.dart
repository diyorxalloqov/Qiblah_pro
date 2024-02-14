import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qiblah_pro/core/singletons/service_locator.dart';
import 'package:qiblah_pro/modules/app.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  runApp(EasyLocalization(
      saveLocale: true,
      startLocale: const Locale("uz"),
      supportedLocales: const [Locale("uz"), Locale("ru")],
      path: "lib/core/lang",
      child: const App()));
}


// import 'package:audio_session/audio_session.dart';
// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   MyAppState createState() => MyAppState();
// }

// class MyAppState extends State<MyApp> with WidgetsBindingObserver {
//   final _player = AudioPlayer();

//   @override
//   void initState() {
//     super.initState();

//     _init();
//   }

//   Future<void> _init() async {
//     final session = await AudioSession.instance;
//     await session.configure(const AudioSessionConfiguration.speech());
//     _player.playbackEventStream.listen((event) {},
//         onError: (Object e, StackTrace stackTrace) {
//       print('STREAM ERROR $e');
//     });
//     try {
//       await _player.setAudioSource(AudioSource.uri(
//           Uri.parse("https://qibla.onrender.com/files/audio/names0.mp3")));
//     } catch (e) {
//       print("Error loading audio source: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: SafeArea(
      //     child: StreamBuilder<PlayerState>(
      //       stream: _player.playerStateStream,
      //       builder: (context, snapshot) {
      //         final playerState = snapshot.data;
      //         final processingState = playerState?.processingState;
      //         final playing = playerState?.playing;
      //         if (processingState == ProcessingState.loading ||
      //             processingState == ProcessingState.buffering) {
      //           return Container(
      //             margin: const EdgeInsets.all(8.0),
      //             width: 64.0,
      //             height: 64.0,
      //             child: const CircularProgressIndicator(),
      //           );
      //         } else if (playing != true) {
                // return IconButton(
                //   icon: const Icon(Icons.play_arrow),
                //   iconSize: 64.0,
                //   onPressed: _player.play,
                // );
      //         } else if (processingState != ProcessingState.completed) {
      //           return IconButton(
      //             icon: const Icon(Icons.pause),
      //             iconSize: 64.0,
      //             onPressed: _player.pause,
      //           );
      //         } else {
      //           return IconButton(
      //             icon: const Icon(Icons.replay),
      //             iconSize: 64.0,
      //             onPressed: () => _player.seek(Duration.zero),
      //           );
      //         }
      //       },
      //     ),
      //   ),
      // ),
//     );
//   }
// }
