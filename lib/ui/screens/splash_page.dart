import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/images/background.svg',
            fit: BoxFit.cover,
            width: screenSize.width,
            height: screenSize.height,
          ),
          Center(
            child: SvgPicture.asset(
              'assets/images/flask-chemistry.svg',
              width: 130,
              fit: BoxFit.scaleDown,
            ),
          )
        ],
      ),
    );
  }
}
