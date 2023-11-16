import 'dart:math';
import 'dart:ui';
import 'dart:io';
import 'package:amazon_app/pages/home/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

Future detailpopupController(BuildContext context, WidgetRef ref) async {
  showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return detailSettingPopup();
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
    final double deviceH = MediaQuery.of(context).size.height;
    final double deviceW = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: deviceH * 0.1,
      ),
      child: Container(
        margin: EdgeInsets.only(
          top:deviceH*0.05,
          bottom: deviceH*0.05,
          right: deviceW*0.03,
          left: deviceW*0.03,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          color: Color.fromRGBO(245, 243, 254, 1),
        ),
        width: 337,
        height: 672,
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
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(3, 3),
                        blurRadius: 10,
                      )
                    ]),
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
                        color: Color.fromRGBO(255, 255, 255, 0.7),
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
                      margin: const EdgeInsets.only(
                        bottom: 3,
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
                margin: const EdgeInsets.only(
                  left: 27,
                  right: 27,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: const Color.fromRGBO(255, 255, 255, 0.8),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(3, 3),
                        blurRadius: 10,
                      )
                    ]),
                child: Column(
                  children: <Widget>[
                    //アイコン変更
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        //今のプロ画
                        Container(
                          padding: const EdgeInsets.only(
                            top: 20,
                          ),
                          height: 86.83,
                          width: 91,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.face,
                            color: Colors.black,
                            size: 80,
                          ),
                        ),
                        //矢印
                        Container(
                          margin: const EdgeInsets.only(
                            top: 29,
                            right: 10,
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.black,
                          ),
                        ),
                        //プロ画更新ボタン
                        Container(
                          margin: const EdgeInsets.only(
                            top: 25,
                          ),
                          height: 75,
                          width: 75,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ),
                          child: CupertinoButton(
                              onPressed: _getImage,
                              child: const Icon(
                                Icons.camera_alt_sharp,
                                color: Colors.white,
                                size: 24,
                              )),
                        ),
                      ],
                    ),
                    //ユーザーネーム変更
                    Container(
                      margin: const EdgeInsets.only(
                        top: 27,
                      ),
                      height: 45.75,
                      width: 212,
                      padding: const EdgeInsets.all(5),
                      child: CupertinoTextField(
                        onChanged: (value) {
                          value == userName;
                          //変更を適応する関数を書く
                        },
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            color: Color.fromARGB(255, 223, 230, 188),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(3, 3),
                                blurRadius: 10,
                              )
                            ]),
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
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(3, 3),
                        blurRadius: 10,
                      )
                    ]),
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
                        color: Color.fromRGBO(255, 255, 255, 0.5),
                      ),
                      child: const Icon(
                        Icons.people_outline,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 22,
                      width: 105,
                      padding: const EdgeInsets.only(
                        left: 28,
                      ),
                      margin: const EdgeInsets.only(
                        bottom: 5,
                      ),
                      child: const Text(
                        '所属団体',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      width: 38,
                      height: 38,
                      alignment: Alignment.centerRight,
                      child: const Icon(
                        Icons.arrow_forward,
                        size: 15,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              //団体一覧
              Container(
                margin: const EdgeInsets.only(
                  top: 8,
                  bottom: 8,
                  left: 29.5,
                  right: 29.5,
                ),
                height: 57,
                width: 318,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(3, 3),
                        blurRadius: 10,
                      )
                    ]),
                child: CupertinoButton(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          height: 48,
                          width: 48,
                          padding: const EdgeInsets.only(
                            left: 15,
                          ),
                          child: const Icon(
                            Icons.face,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          width: 183,
                          height: 22,
                          alignment: Alignment.center,
                          child: const Text(
                            '仮のグループ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const HomePage()));
                    }),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 8,
                  bottom: 8,
                  left: 29.5,
                  right: 29.5,
                ),
                height: 57,
                width: 318,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(3, 3),
                        blurRadius: 10,
                      )
                    ]),
                child: CupertinoButton(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          height: 48,
                          width: 48,
                          padding: const EdgeInsets.only(
                            left: 15,
                          ),
                          child: const Icon(
                            Icons.face,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          width: 183,
                          height: 22,
                          alignment: Alignment.center,
                          child: const Text(
                            '仮のグループ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const HomePage()));
                    }),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 8,
                  bottom: 8,
                  left: 29.5,
                  right: 29.5,
                ),
                height: 57,
                width: 318,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(3, 3),
                        blurRadius: 10,
                      )
                    ]),
                child: CupertinoButton(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          height: 48,
                          width: 48,
                          padding: const EdgeInsets.only(
                            left: 15,
                          ),
                          child: const Icon(
                            Icons.face,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          width: 183,
                          height: 22,
                          alignment: Alignment.center,
                          child: const Text(
                            '仮のグループ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        )
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
      ),
    );
  }
}


























//ポップアップの設定ですが、ポップアップをクラスで囲って設定してしまうと、ポップアップ自体、表示はされますが、ポップアップ以外の画面をタップしてもポップアップを閉じることはできないので、注意！

//なので、個人的には関数でポップアップを管理した方がいいと思います！！

//私が作成したポップアップの機能はgithubに載っけているので、困ったら見てみると良いかも！
//https://github.com/YoungmanCH/calendar_intern_repo