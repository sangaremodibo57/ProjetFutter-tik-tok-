import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:video_player/video_player.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Tam Tam',
      debugShowCheckedModeBanner: false,
      home:  MyStatefulWidget(),
    );
  }
}
// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, elevation: 0.0, // 1
        leading:const Icon(Icons.live_tv),
        title:  IconTitleWidget(),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.search),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: HomePage(),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const  BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
            backgroundColor: Colors.black
          ),
          const  BottomNavigationBarItem(
            icon: Icon(Icons.access_time_sharp),
            label: 'Découvrir',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/tiktok_add.png', height: 30,),
            label: '',
            backgroundColor: Colors.black
          ),
          const  BottomNavigationBarItem(
            icon: Icon(Icons.message_rounded),
            label: 'Boîte de réception',
          ),
         const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Moi',
          ),
        ],
        currentIndex: _selectedIndex,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
//top bar
class IconTitleWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // Centers horizontally
      crossAxisAlignment: CrossAxisAlignment.center, // Centers vertically
      children: const <Widget>[
        Text('Abonnements '),
        // The SizedBox provides an immediate spacing between the widgets
        SizedBox(
          width: 3,
        ),
        Text(
          " Pour Toi",
        )
      ],
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final List<Map> data = [
    {
      "title": "Ma première fois dans\n l'ascenseur - une vie de tto\n ",
      "video": "assets/videos/V14.mp4",
      "nom":"@MS007",
    },
    {
      "title": " DIARABI DOUMANI ADAN ADAN \n ",
      "video": "assets/videos/V9.mp4",
      "nom":"@Blasko",
    },
    {
    "nom":"@Sirakiss",
      "video": "assets/videos/V8.mp4",
      "title": "parole douman \n dance bizzarrrr \n ",
    },
    {
    "nom":"@Basoumano",
      "video": "assets/videos/V16.mp4",
      "title": "Mali dew regarder très bien aw ko tokodi\n Stop Merci \n ",
    },
    {
      "nom":"@Leïla",
      "video": "assets/videos/V7.mp4",
      "title": "C'est zooooo\n ",
    },
    {
    "nom":"@LaZooo",
      "video": "assets/videos/V10.mp4",
      "title": "Toi et toi seul\n ",
    },
    {
    "nom":"Modibo sangare",
      "video": "assets/videos/V10.mp4",
      "title": "Image 1  gdfhgshdfghs dgfhgshdg\n ",
    },
    {
    "nom":"Modibo sangare",
      "video": "assets/videos/V11.mp4",
      "title": "Image 1  gdfhgshdfghs dgfhgshdg\n ",
    },
    {
    "nom":"Modibo sangare",
      "video": "assets/videos/V12.mp4",
      "title": "Image 1  gdfhgshdfghs dgfhgshdg\n ",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        enableInfiniteScroll: false,
        height: double.infinity,
        scrollDirection: Axis.vertical,
        viewportFraction: 1.0,
      ),
      items: data.map((item) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              color: const Color(0xFF141518),
              child:Stack(
                children: [

                  VideoWidget(
                    videoUrl: item['video'],
                  ),

                  Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                          Text(
                          item["nom"],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10,width: 20,),
                           Text(
                                item["title"],
                                style: const TextStyle(
                                color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                      ]),
                  const PostContent(),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }
}



class VideoWidget extends StatefulWidget {
  VideoWidget({Key? key, required this.videoUrl}) : super(key: key);
  final String videoUrl;
  @override
  _VideoWidgetState createState() => _VideoWidgetState(this.videoUrl);
}

class _VideoWidgetState extends State<VideoWidget> {
  final String videoUrl;
  late VideoPlayerController _controller;

  _VideoWidgetState(this.videoUrl);

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(videoUrl)
      ..initialize().then((_) {
        _controller.setLooping(true); // à ajouter pour la lecture en boucle
        _controller.play(); // pour lancer la lecture vidéo
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return VideoPlayer(_controller);
  }
}

class PostContent extends StatelessWidget {
  const PostContent({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          children: const [
                            Icon(
                              Icons.music_note,
                              color: Colors.white,
                              size: 15,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Original Sound - extremesports_95',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 80,
                  padding: EdgeInsets.only(bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding:const EdgeInsets.all(10),
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Container(
                              margin:const EdgeInsets.only(bottom: 10),
                              child: const CircleAvatar(
                                radius: 25,
                                backgroundImage: AssetImage(
                                  'assets/images/icone.jpeg',
                                ),
                              ),
                            ),
                            Container(
                              padding:const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 15,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 80,
                        child: Column(
                          children: [
                            Icon(
                              Icons.favorite,
                              color: Colors.white.withOpacity(0.85),
                              size: 45,
                            ),
                            const Text(
                              '25.0K',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 80,
                        child: Column(
                          children: [
                            Icon(
                              Icons.message_rounded,
                              color: Colors.white.withOpacity(0.85),
                              size: 45,
                            ),
                            const Text(
                              '156',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 80,
                        child: Column(
                          children: [
                            Icon(
                              Icons.shortcut_sharp,
                              color: Colors.white.withOpacity(0.85),
                              size: 45,
                            ),
                           const Text(
                              '123',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                      AnimatedLogo(),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
class AnimatedLogo extends StatefulWidget {
  AnimatedLogo({Key? key}) : super(key: key);

  @override
  _AnimatedLogoState createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    );
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Animation sur disck
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * math.pi,
          child: child,
        );
      },
      //Lecteur disck
      child: Container(
        height: 45,
        width: 45,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          image: const DecorationImage(
            image: AssetImage("assets/images/disc_icon.png"),
          ),
        ),
        child: Image.asset('assets/images/tiktok_icon.png'),
      ),
    );
  }
}