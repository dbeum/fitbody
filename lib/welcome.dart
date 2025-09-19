import 'package:fitbody/login.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  List<ContentConfig> slides = [];

  @override
  void initState() {
    super.initState();

    slides.add(
      const ContentConfig(
        //    title: "Welcome",
        //   description: "This is the first intro screen",
        pathImage: "assets/images/w12.png",
        backgroundImage: "assets/images/w1.png",
      ),
    );

    slides.add(
      const ContentConfig(
        // title: "Features",
        // description: "Highlight your app features here",
        pathImage: "assets/images/g1.png",
        backgroundImage: "assets/images/w2.png",
      ),
    );

    slides.add(
      const ContentConfig(
        // title: "Features",
        // description: "Highlight your app features here",
        pathImage: "assets/images/g2.png",
        backgroundImage: "assets/images/w3.png",
      ),
    );
    slides.add(
      const ContentConfig(
        // title: "Features",
        // description: "Highlight your app features here",
        pathImage: "assets/images/g3.png",
        backgroundImage: "assets/images/w4.png",
      ),
    );
  }

  void onDonePress() {
    // Navigate to home screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(listContentConfig: slides, onDonePress: onDonePress);
  }
}
