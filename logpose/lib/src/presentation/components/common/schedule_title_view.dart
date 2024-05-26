import 'package:flutter/cupertino.dart';

class ScheduleTitleView extends StatelessWidget {
  const ScheduleTitleView({
    super.key,
    required this.title,
    this.width,
    required this.marginTop,
    required this.fontSize,
  });

  final String title;
  final double? width;
  final double marginTop;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: marginTop),
      width: width,
      child: Text(title, style: TextStyle(fontSize: fontSize)),
    );
  }
}
