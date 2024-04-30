import 'package:flutter/cupertino.dart';

class Gradation extends StatelessWidget {
  const Gradation({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      width: deviceWidth,
      height: deviceHeight * 0.12,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xff76548C).withOpacity(0),
            const Color.fromARGB(255, 26, 7, 100).withOpacity(0.3),
            const Color.fromARGB(255, 22, 0, 109).withOpacity(0.4),
            const Color.fromARGB(255, 159, 146, 225).withOpacity(0.7),
          ],
          stops: const [0, 0.5, 0.8, 0.99],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
