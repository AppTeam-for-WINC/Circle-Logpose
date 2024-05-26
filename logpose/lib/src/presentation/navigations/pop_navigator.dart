import 'package:flutter/cupertino.dart';

class PopNavigator {
  PopNavigator(this.context);
  final BuildContext context;

  void pop() {
    Navigator.of(context).pop();
  }
}
