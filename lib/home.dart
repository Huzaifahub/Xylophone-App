import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  int? playingNumber;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void playMusic(int number) async {
    if (playingNumber == number && isPlaying) {
      await _audioPlayer.pause();
      setState(() {
        isPlaying = false;
      });
    } else {
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource('note$number.wav'));
      setState(() {
        isPlaying = true;
        playingNumber = number;
      });
    }
  }

  Widget customCard(int number, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 6, // Elevation gives a shadow effect
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          leading: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            child: Icon(
              isPlaying && playingNumber == number ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
            ),
          ),
          title: Text(
            "Music $number",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          subtitle: Text(
            "Tap to play and pause",
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
          trailing: Icon(
            Icons.volume_up,
            color: Colors.blueAccent,
          ),
          onTap: () {
            playMusic(number);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: Text(
            'Xylophone App',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.grey[100], // Subtle background color
          child: ListView(
            children: [
              SizedBox(height: 20),
              customCard(1, "Play and Pause 1"),
              customCard(2, "Play and Pause 2"),
              customCard(3, "Play and Pause 3"),
              customCard(4, "Play and Pause 4"),
              customCard(5, "Play and Pause 5"),
              customCard(6, "Play and Pause 6"),
              customCard(7, "Play and Pause 7"),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
