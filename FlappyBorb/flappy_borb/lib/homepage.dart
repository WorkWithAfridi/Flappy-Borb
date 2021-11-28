import 'dart:async';

import 'package:flappy_borb/barriers.dart';
import 'package:flappy_borb/bird_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static String routeName = '/homepage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYaxis;
  bool gameHasStarted = false;
  static double barrierXone = 1.5;
  double barrierXtwo = barrierXone + 1.5;
  double barrierXthree = barrierXone + 3.0;

  int score = 0;
  int best = 0;

  bool showEngGamePopup = false;

  void retry() {
    score = 0;
    birdYaxis = 0;
    time = 0;
    height = 0;
    initialHeight = birdYaxis;
    gameHasStarted = false;
    barrierXone = 1.5;
    barrierXtwo = barrierXone + 1.5;
    barrierXthree = barrierXone + 2.5;
    showEngGamePopup = false;

    Navigator.of(context).pushReplacementNamed(HomePage.routeName);
  }

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      Alignment barrierOneAlignmentTop = Alignment(barrierXone, 1.6);
      Alignment barrierOneAlignmentBottom = Alignment(barrierXone, -1.4);

      Alignment barrierTwoAlignmentTop = Alignment(barrierXone, 1.6);
      Alignment barrierTwoAlignmentBottom = Alignment(barrierXone, -1.6);

      Alignment barrierThreeAlignmentTop = Alignment(barrierXone, 1.1);
      Alignment barrierThreeAlignmentBottom = Alignment(barrierXone, 1.1);

      Alignment birdAlignment = Alignment(0, birdYaxis + 1);

      //
      // if(barrierXone>0.099 && barrierXone<0.1000){
      //
      //   print(barrierXone);
      // }
      if(barrierXtwo>0.099 && barrierXtwo<0.1000){

        print(barrierXtwo);
      }

      // print(barrierXtwo);
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initialHeight - height;
        barrierXone -= 0.05;
        barrierXtwo -= 0.05;
      });
      setState(() {
        if (barrierXone < -1.5) {
          score++;
          barrierXone = 1.8;
        } else {
          barrierXone -= 0.05;
        }
      });
      setState(() {
        if (barrierXtwo < -1.5) {
          barrierXtwo = 1.8;
          score++;
        } else {
          barrierXtwo -= 0.05;
        }
      });
      if (birdYaxis > 1) {
        timer.cancel();
        gameHasStarted = false;
        showEngGamePopup = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black87,
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Stack(
                    children: [
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        child: Image.asset(
                          'lib/images/dragonduck.jpg',
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      Container(
                        alignment: Alignment(0, 0.25),
                        child: gameHasStarted
                            ? Container()
                            : const Text(
                                'TAP TO START',
                                style: TextStyle(
                                    fontSize: 13,
                                    wordSpacing: 3,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 0),
                        alignment: Alignment(barrierXone, 1.6),
                        child: Barrier(200.0),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 0),
                        alignment: Alignment(barrierXone, -1.4),
                        child: Barrier(200.0),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 0),
                        alignment: Alignment(barrierXtwo, 1.6),
                        child: Barrier(150.0),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 0),
                        alignment: Alignment(barrierXtwo, -1.6),
                        child: Barrier(250.0),
                      ),
                      // AnimatedContainer(
                      //   duration: Duration(milliseconds: 0),
                      //   alignment: Alignment(barrierXthree, 1.2),
                      //   child: Barrier(150.0),
                      // ),
                      // AnimatedContainer(
                      //   duration: Duration(milliseconds: 0),
                      //   alignment: Alignment(barrierXthree, -1.2),
                      //   child: Barrier(250.0),
                      // ),
                      AnimatedContainer(
                        alignment: Alignment(0, birdYaxis),
                        duration: Duration(milliseconds: 0),
                        child: Container(
                          height: 66,
                          width: 66,
                          child: Bird(),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 15,
                  color: Colors.blueGrey,
                  // decoration: BoxDecoration(
                  //   color: Colors.green,
                  //   border: Border.all(
                  //     width: 2,
                  //     color: Colors.black,
                  //   ),
                  // ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      // Expanded(
                      //     child: Container(
                      //   height: double.infinity,
                      //   width: double.infinity,
                      //   child: Image.asset('lib/images/soil.jpg', fit: BoxFit.fitWidth,),
                      // )),
                      Container(
                        color: Color(0xff41414A),
                        child: gameHasStarted
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'SCORE:',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 10),
                                      ),
                                      Text(
                                        score.toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 45,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'BEST:',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 10),
                                      ),
                                      Text(
                                        best.toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 45,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        'Flappy Borb.',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            wordSpacing: 0,
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 25),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        'By Kyoto. :)',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            wordSpacing: 0,
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 13),
                                        textAlign: TextAlign.center,
                                      ),
                                      // const SizedBox(
                                      //   height: 30,
                                      // ),
                                      // Text(
                                      //   'ANGRY BIRD AND FLAPPY BIRD DEVELOPERS \nPLS DONT SUE ME! ',
                                      //   textAlign: TextAlign.center,
                                      //   style: TextStyle(
                                      //       fontWeight: FontWeight.bold,
                                      //       color: Colors.black.withOpacity(.9),
                                      //       wordSpacing: 1),
                                      // ),
                                      // const SizedBox(
                                      //   height: 10,
                                      // ),
                                    ],
                                  )
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            showEngGamePopup
                ? AlertDialog(
                    title: const Text("Oh damn"),
                    content:
                        const Text("Borb died!! :("),
                    actions: [
                      Center(
                        child: Container(
                          width: 150,
                          child: ElevatedButton(
                            onPressed: () {
                              retry();
                            },
                            child: const Text(
                              'Retry',
                              style: TextStyle(fontSize: 20),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.redAccent),
                          ),
                        ),
                      )
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
