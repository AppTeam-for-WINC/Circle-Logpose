import 'package:flutter/material.dart';

enum ResponseType { attendance, leaveEarly, lateness, absence }

class ScheduleResponse {
  const ScheduleResponse();

  static Icon getIcon(ResponseType type, double iconSize) {
    switch (type) {
      case ResponseType.attendance:
        return Icon(
          Icons.sentiment_very_satisfied,
          size: iconSize,
          color: Colors.black,
        );
      case ResponseType.leaveEarly:
        return Icon(
          Icons.sentiment_dissatisfied,
          size: iconSize,
          color: Colors.black,
        );
      case ResponseType.lateness:
        return Icon(
          Icons.sentiment_dissatisfied,
          size: iconSize,
          color: Colors.black,
        );
      case ResponseType.absence:
        return Icon(
          Icons.sentiment_very_dissatisfied,
          size: iconSize,
          color: Colors.black,
        );
    }
  }

  static Text getText(ResponseType type, double textSize) {
    switch (type) {
      case ResponseType.attendance:
        return Text('出席', style: TextStyle(fontSize: textSize));
      case ResponseType.leaveEarly:
        return Text('早退', style: TextStyle(fontSize: textSize));
      case ResponseType.lateness:
        return Text('遅刻', style: TextStyle(fontSize: textSize));
      case ResponseType.absence:
        return Text('欠席', style: TextStyle(fontSize: textSize));
    }
  }
}
