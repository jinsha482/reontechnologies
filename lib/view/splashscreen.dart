import 'package:flutter/material.dart';
import 'package:uploadimage/view/homescreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 7), () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomeScreen()));
    });

    return Scaffold(
      body: Container(
        color: Color.fromRGBO(128, 50, 50, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.0038)
                        ..rotateY(-0.4),
                      child: Image.asset(
                        fit: BoxFit.cover,
                        'assets/images/pexels-kindel-media-7148409.png',
                        width: 120,
                        height: 110,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Image.asset(
                      fit: BoxFit.cover,
                      'assets/images/pexels-kindel-media-7149165.png',
                      width: 130,
                      height: 110,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.002)
                        ..rotateY(0.5),
                      child: Image.asset(
                        fit: BoxFit.cover,
                        'assets/images/pexels-kindel-media-7149131.png',
                        width: 120,
                        height: 110,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'S',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'nap',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(
                    text: 'Mosaic',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(-0.4),
                      child: Image.asset(
                        fit: BoxFit.cover,
                        'assets/images/pexels-keira-burton-6146961 (1).png',
                        width: 120,
                        height: 100,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      fit: BoxFit.cover,
                      'assets/images/pexels-william-fortunato-6141099.png',
                      width: 100,
                      height: 97,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Transform(
                      transform: Matrix4.identity()
                        ..setEntry(2, 1, 0.001)
                        ..rotateY(0.4),
                      child: Image.asset(
                        fit: BoxFit.cover,
                        'assets/images/pexels-ketut-subiyanto-4350302.png',
                        width: 120,
                        height: 100,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
