import 'dart:math';
import 'dart:ui';
import 'dart:io';
import 'package:amazon_app/pages/home/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

Future detailpopupController(BuildContext context, WidgetRef ref) async {
  final double deviceH = MediaQuery.of(context).size.height;
  final double deviceW = MediaQuery.of(context).size.width;
  showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
            height: 672,
            width: 337,
            padding: EdgeInsets.only(bottom: deviceH * 0.07),
            child: PageView.builder(
              itemBuilder: (context, index) {
                return detailSettingPopup();
              },
            ));
      });
}

class detailSettingPopup extends ConsumerStatefulWidget {
  const detailSettingPopup({super.key});
  @override
  ConsumerState<detailSettingPopup> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<detailSettingPopup> {
  final picker = ImagePicker();
  File? _image;
  String userName = '';
  Future _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPopupSurface(
      child: Center(
        child: Column(
          children: <Widget>[
            //ユーザー接待
            Container(
              margin: const EdgeInsets.only(
                top: 18,
                bottom: 18,
              ),
              height: 44,
              width: 200,
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(80, 49, 238, 1),
                  //なぜかcircurateできなかった。
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(22),
                    bottomRight: Radius.circular(22),
                    topRight: Radius.circular(22),
                    topLeft: Radius.circular(22),
                  )),
              child: Row(
                children: <Widget>[
                  //アイコン
                  Container(
                    margin: const EdgeInsets.only(
                      left: 4,
                    ),
                    padding: const EdgeInsets.all(0),
                    height: 38,
                    width: 38,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const Icon(
                      Icons.person_outlined,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    height: 22,
                    width: 100,
                    padding: const EdgeInsets.only(
                      left: 30,
                    ),
                    child: const Text(
                      'ユーザー設定',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //アイコンなど
            Container(
              height: 197,
              width: 323,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  //アイコン変更
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //今のプロ画
                      Container(
                        padding: const EdgeInsets.only(
                          top: 10,
                        ),
                        height: 86.83,
                        width: 91,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.face,
                          color: Colors.black,
                          size: 89,
                        ),
                      ),
                      //矢印
                      Container(
                        margin: const EdgeInsets.only(
                          top: 15,
                        ),
                        child: const Icon(Icons.arrow_forward),
                      ),
                      //プロ画更新ボタン
                      Container(
                        margin: const EdgeInsets.only(
                          top: 15,
                        ),
                        height: 86.83,
                        width: 91,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                        child: CupertinoButton(
                            child: Icon(
                              Icons.camera_alt_sharp,
                              color: Colors.white,
                              size: 45,
                            ),
                            onPressed: _getImage),
                      ),
                    ],
                  ),
                  //ユーザーネーム変更
                  Container(
                    
                    margin: const EdgeInsets.only(
                      top: 32,
                    ),
                    height: 45.75,
                    width: 212,
                    child: CupertinoTextField(
                      onChanged: (value) {
                        value == userName;
                      },
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: const Color.fromRGBO(216, 235, 97, 1),
                    ),
                    ),
                  ),
                ],
              ),
            ),
            //所属団体
            Container(
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.all(18),
              height: 44,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: const Color.fromRGBO(216, 235, 97, 1),
              ),
              child: Row(
                children: <Widget>[
                  //アイコン
                  Container(
                    margin: const EdgeInsets.only(
                      left: 4,
                    ),
                    padding: const EdgeInsets.all(0),
                    height: 38,
                    width: 38,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const Icon(
                      Icons.people_outline,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    height: 22,
                    width: 100,
                    padding: EdgeInsets.only(
                      left: 30,
                    ),
                    child: const Text(
                      '所属団体',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            //団体一覧
            Container(
              margin: const EdgeInsets.all(18),
              height: 57,
              width: 318,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
              ),
              child: CupertinoButton(
                  child: const Row(
                    children: <Widget>[
                      Icon(Icons.face),
                      Text('仮の名前'),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const HomePage()));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}


























//ポップアップの設定ですが、ポップアップをクラスで囲って設定してしまうと、ポップアップ自体、表示はされますが、ポップアップ以外の画面をタップしてもポップアップを閉じることはできないので、注意！

//なので、個人的には関数でポップアップを管理した方がいいと思います！！

//私が作成したポップアップの機能はgithubに載っけているので、困ったら見てみると良いかも！
//https://github.com/YoungmanCH/calendar_intern_repo