import 'package:flutter/material.dart';

enum ResponseType { attendance, leaveEarly, lateness, absence }

class ScheduleResponse {
  const ScheduleResponse();

  static Icon getIcon(ResponseType type) {
    switch (type) {
      case ResponseType.attendance:
        return const Icon(
          Icons.sentiment_very_satisfied,
          size: 25,
          color: Colors.black,
        );
      case ResponseType.leaveEarly:
        return const Icon(
          Icons.sentiment_dissatisfied,
          size: 25,
          color: Colors.black,
        );
      case ResponseType.lateness:
        return const Icon(
          Icons.sentiment_dissatisfied,
          size: 25,
          color: Colors.black,
        );
      case ResponseType.absence:
        return const Icon(
          Icons.sentiment_very_dissatisfied,
          size: 25,
          color: Colors.black,
        );
    }
  }

  static Text getText(ResponseType type) {
    switch (type) {
      case ResponseType.attendance:
        return const Text('出席', style: TextStyle(fontSize: 18));
      case ResponseType.leaveEarly:
        return const Text('早退', style: TextStyle(fontSize: 18));
      case ResponseType.lateness:
        return const Text('遅刻', style: TextStyle(fontSize: 18));
      case ResponseType.absence:
        return const Text('欠席', style: TextStyle(fontSize: 18));
    }
  }
}
