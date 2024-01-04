import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../schedule_create_controller.dart';

void showTeamPicker(
  BuildContext context,
  ScheduleCreationData schedule,
  void Function(int)? onSelectedItemChanged,
) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) {
      //以下の内容をクラスで囲えばよろしい。
      return Container(
        height: 200,
        width: 360,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.zero,
              height: 140,
              margin: const EdgeInsets.only(
                top: 10,
              ),
              child: CupertinoPicker(
                itemExtent: 40,
                onSelectedItemChanged: onSelectedItemChanged,
                children: List.generate(
                  schedule.groupNames!.length,
                  (index) => Center(
                    child: Text(schedule.groupNames![index]),
                  ),
                ),
              ),
            ),
            CupertinoButton(
              padding: const EdgeInsets.only(
                bottom: 6,
              ),
              alignment: Alignment.bottomLeft,
              child: const Text(
                'Close',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.blue,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}
