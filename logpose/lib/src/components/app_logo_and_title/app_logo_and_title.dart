import 'package:flutter/cupertino.dart';

class AppLogoAndTitle extends StatelessWidget {
  const AppLogoAndTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(23),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/logpose/Logpose.png',
            width: 100,
            height: 100,
          ),
          const Text(
            'Logpose',
            style: TextStyle(
              color: CupertinoColors.white,
              fontSize: 40,
              fontFamily: 'Shippori_Mincho_B1',
            ),
          ),
        ],
      ),
    );
  }
}
