import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../animations/fade_animation.dart';
import 'dashboard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required String title});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late PageController _pageController;

  late AnimationController rippleController;
  late AnimationController scaleController;

  late Animation<double> rippleAnimation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    rippleController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    scaleController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade, child: Dashboard()));
            }
          });

    rippleAnimation =
        Tween<double>(begin: 80.0, end: 90.0).animate(rippleController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              rippleController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              rippleController.forward();
            }
          });

    scaleAnimation =
        Tween<double>(begin: 1.0, end: 30.0).animate(scaleController);

    rippleController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          makePage(
              image: 'assets/images/musculation.jpg',
              title: 'Volume up your body goals'),
          makePage(
              image: 'assets/images/one.jpg',
              title: 'reach your goals with Fitness App'),
          makePage(
              image: 'assets/images/three.jpg',
              title: 'spend some fun time at home'),
        ],
      ),
    );
  }

  Widget makePage({required String image, required String title}) {
    return Container(
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.black.withOpacity(.3),
            Colors.black.withOpacity(.3),
          ])),
          child: Padding(
            padding: const EdgeInsets.all(35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 60,
                ),
                FadeAnimation(
                  1,
                  Text(
                    title.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeAnimation(
                      1,
                      Text(
                        "15",
                        style: TextStyle(
                            color: Colors.yellow[400],
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const FadeAnimation(
                      1.2,
                      Text(
                        "Minutes",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeAnimation(
                      1,
                      Text(
                        "3",
                        style: TextStyle(
                            color: Colors.yellow[400],
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const FadeAnimation(
                        1.2,
                        Text(
                          "Exercises",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 180,
                ),
                const FadeAnimation(
                    1,
                    Align(
                      child: Text(
                        "Start the morning with your health",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w100),
                      ),
                    )),
                const SizedBox(
                  height: 30,
                ),
                FadeAnimation(
                    1,
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: AnimatedBuilder(
                        animation: rippleAnimation,
                        builder: (context, child) => SizedBox(
                          width: rippleAnimation.value,
                          height: rippleAnimation.value,
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(.4)),
                            child: InkWell(
                              onTap: () {
                                scaleController.forward();
                              },
                              child: AnimatedBuilder(
                                animation: scaleAnimation,
                                builder: (context, child) => Transform.scale(
                                  scale: scaleAnimation.value,
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
