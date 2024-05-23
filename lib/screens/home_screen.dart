import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solar_system/Services/card.dart';
import 'package:solar_system/screens/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Cardd> cards = [
    Cardd(name: 'Sun', image: 'sun.jpg', description: 'This is the Sun'),
    Cardd(
        name: 'Mercury',
        image: 'mercury.jpg',
        description: 'This is the Mercury'),
    Cardd(name: 'Earth', image: 'earth.jpg', description: 'This is the Earth'),
    Cardd(
        name: 'Jupiter',
        image: 'jupiter.jpg',
        description: 'This is the Jupiter'),
    Cardd(name: 'Mars', image: 'mars.jpg', description: 'This is the Mars'),
    Cardd(
        name: 'Neptune',
        image: 'neptune.jpg',
        description: 'This is the neptune'),
    Cardd(name: 'Pluto', image: 'pluto.jpg', description: 'This is the Pluto'),
    Cardd(
        name: 'Saturn', image: 'saturn.jpg', description: 'This is the Saturn'),
    Cardd(
        name: 'Uranus', image: 'uranus.jpg', description: 'This is the Uranus'),
  ];
  int timing = 0;
  int index = 0;
  Timer? _timer;
  bool isRun = true;
  int timeDuration = 0;

  String username = 'unknown';

  @override
  void initState() {
    super.initState();
    getData();
    _startCountdown();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      timeDuration = prefs.getInt('timeDuration') ?? 0;
      timing = timeDuration;
      username = prefs.getString('username').toString();
    });
  }

  Future<void> updateData() async {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is Map<String, dynamic>) {
      timeDuration = args['timeDuration'] as int;
      username = args['username'] as String;
    } else {
      timeDuration = 0;
      username = 'Unknown';
    }
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timing > 0) {
        setState(() {
          timing--;
        });
      } else {
        setState(() {
          timing = timeDuration;
          index = Random().nextInt(cards.length - 1);
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: const Text(
              'Solar System information',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.blue[900],
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.settings),
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingScreen(),
                    ),
                  );
                },
              ),
            ]),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 40),
                  // time
                  Text(
                    ' Thời gian còn lại : $timing',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[800]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    ' Hello : $username',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[800]),
                  ),
                  const SizedBox(height: 8),
                  // element images
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            offset: Offset(5.0, 5.0),
                            blurRadius: 5.0,
                            spreadRadius: 1.0),
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 300,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/images/${cards[index].image}',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          cards[index].name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // descriptions
                        SizedBox(
                          height: 100,
                          child: Text(
                            cards[index].description,
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  //button
                  ElevatedButton(
                    onPressed: () {
                      print('onPress: $isRun');
                      isRun = !isRun;
                      if (isRun) {
                        _startCountdown();
                      } else {
                        _timer?.cancel();
                      }
                    },
                    child: const Text(
                      'Stops',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
