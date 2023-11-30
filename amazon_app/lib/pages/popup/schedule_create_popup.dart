import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:amazon_app/database/database.dart';
import '/pages/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

User? user = FirebaseAuth.instance.currentUser;


class ScheduleCreatePopup extends ConsumerStatefulWidget {
  const ScheduleCreatePopup({super.key});

  @override
  // ignore: library_private_types_in_public_api
  ConsumerState createState() => ScheduleCreatePopupState();
}

class ScheduleCreatePopupState extends ConsumerState {
  TextEditingController titleController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController placeController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  String selectedTeam = 'Team1';
  List<String> teams = ['Team1', 'Team2', 'Team3', 'Team4'];
  void _showTeamPicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: CupertinoPicker(
            itemExtent: 40,
            onSelectedItemChanged: (int index) {
              setState(() {
                selectedTeam = teams[index];
              });
            },
            children: List.generate(
              teams.length,
              (index) => Center(
                child: Text(teams[index]),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPopupSurface(
      child: SizedBox(
        width: 360,
        height: 500,
        child: Stack(
          children: [
            // ポップアップ下部の白色↓
            Container(
              width: double.infinity,
              height: 500,
              decoration: const BoxDecoration(color: Colors.white),
            ),
            // ポップアップ下部の白色↑
            CupertinoButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xFF7B61FF),
                )),
            // カラー選択↓
            const Positioned(
              top: 50,
              left: 30,
              child: Icon(
                Icons.color_lens,
                size: 50,
                color: Colors.grey,
              ),
            ),
            // カラー選択↑

            // タイトル追加↓
            //ここのContainer切り出す
            Container(
              margin: const EdgeInsets.only(top: 110, left: 40),
              width: 270, // 横幅を指定
              child: CupertinoTextField(
                placeholder: 'タイトルを追加',
                placeholderStyle: const TextStyle(color: Colors.grey),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: CupertinoColors.black,
                      width: 1.0,
                    ),
                  ),
                ),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                onChanged: (title) async {
                  // タイトルをデータベースに保存
                  if (user != null) {
                    String uid = user!.uid;
                    Map<String, dynamic> titleData = {"schedule_title": title};
                    // uidをdocIdとして使って関数を呼び出す
                    updateDocumentData('schedule_info', uid, titleData);
                  } else {
                    // userがnullの場合、サインインしていない旨の処理を行うか、エラーハンドリングを行う
                    debugPrint('ユーザーがサインインしていません');
                  }
                },
              ),
            ),
            // タイトル追加↑
            Container(
              margin: const EdgeInsets.only(
                left: 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 団体選択↓
                  //ここのContainer切り出す
                  Container(
                    margin: const EdgeInsets.only(top: 160),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.expand_more,
                          color: Colors.grey,
                        ),
                        CupertinoButton(
                          onPressed: () {
                            _showTeamPicker(context); // 団体選択の処理
                          },
                          child: Text(
                            selectedTeam,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Color(0xFF7B61FF),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 団体選択↑
                  // 活動日時↓
                  //ここのContainer切り出す
                  Container(
                    margin: const EdgeInsets.only(),
                    child: Row(children: [
                      const Icon(
                        Icons.schedule,
                        size: 25,
                        color: Colors.grey,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        child: const Text(
                          '2023/10/19   13:00-14:00',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ]),
                  ),
                  // 活動日時↑
                  // 場所↓
                  //ここのContainer切り出す
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.place,
                          size: 25,
                          color: Colors.grey,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          width: 100,
                          child: CupertinoTextField(
                            placeholder: '場所を追加',
                            placeholderStyle:
                                const TextStyle(color: Colors.grey),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  style: BorderStyle.none,
                                ),
                              ),
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            onChanged: (place) async {
                              // タイトルをデータベースに保存
                              if (user != null) {
                                String uid = user!.uid;
                                Map<String, dynamic> placeData = {"schedule_place": place};
                                // uidをdocIdとして使って関数を呼び出す
                                updateDocumentData('schedule_info', uid, placeData);
                              } else {
                                // userがnullの場合、サインインしていない旨の処理を行うか、エラーハンドリングを行う
                                debugPrint('ユーザーがサインインしていません');
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 場所↑
                  // 詳細のコンテナ↓
                  //ここのContainer切り出す
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // 詳細左部のアイコン↓
                            const Icon(
                              Icons.edit_square,
                              size: 25,
                              color: Colors.grey,
                            ),
                            // 詳細左部のアイコン↑
                            // 詳細テキスト↓
                            Container(
                              margin: const EdgeInsets.only(left: 8),
                              width: 100,
                              child: CupertinoTextField(
                                placeholder: '詳細を追加',
                                placeholderStyle:
                                    const TextStyle(color: Colors.grey),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                ),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                onChanged: (content) async {
                                  // タイトルをデータベースに保存
                                  String uid = user!.uid;
                                  Map<String, dynamic> detailData = {"schedule_content": content};
                                  // uidをdocIdとして使って関数を呼び出す
                                  updateDocumentData('schedule_info', uid, detailData);
                                  
                                },
                              ),
                            ),
                            // 詳細テキスト↑
                          ],
                        ),
                        // 詳細内容↑
                      ],
                    ),
                  ),
                  // 詳細のコンテナ↑
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//DateTime pickerです。(未完成)
class ReservationTimeSelector extends StatelessWidget {
  final TimeOfDay selectedTime;

  const ReservationTimeSelector(this.selectedTime, {super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoDatePicker(
      mode: CupertinoDatePickerMode.time,
      initialDateTime: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        selectedTime.hour,
        selectedTime.minute,
      ),
      onDateTimeChanged: (newDateTime) {
        Navigator.of(context).pop(TimeOfDay(
          hour: newDateTime.hour,
          minute: newDateTime.minute,
        ));
      },
    );
  }
}
