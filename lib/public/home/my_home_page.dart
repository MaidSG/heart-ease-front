import 'package:heart_ease_front/common/api/DioManager.dart';
import 'package:heart_ease_front/common/api/ErrorEntity.dart';
import 'package:heart_ease_front/common/api/RequestMethod.dart';
import 'package:heart_ease_front/common/components/wechat/wx_button_phone_auth.dart';
import 'package:heart_ease_front/http.dart';
import 'package:heart_ease_front/public/home/card_item.dart';
import 'package:heart_ease_front/public/home/carousel_slider.dart';
import 'package:heart_ease_front/public/home/info_section.dart';
import 'package:heart_ease_front/public/home/login_data_model.dart';
import 'package:heart_ease_front/router/application.dart';
import 'package:heart_ease_front/router/routers.dart';
import 'package:mpflutter_core/mpflutter_core.dart';
import 'package:mpflutter_wechat_api/mpflutter_wechat_api.dart' as mp;
import 'package:mpflutter_core/mpjs/mpjs.dart' as mpjs;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  String _text = '';

  @override
  void initState() {
    super.initState();
    _login();
  }

  Future<void> _login() async {
    mp.wx.login(mp.LoginOption()
      ..success = (result) async {
        print('Code = ${result.code}');
        final snackBar = SnackBar(
          content: Text('Code = ${result.code}'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        // 拿到 code 后 通过 code 换取 token
        try {
          await DioManager().request(
            RequestMethod.POST,
            '/sys/auth/wx/login',
            params: <String, dynamic>{'code': result.code}, // 替换为实际的 code
            success: (data) {
              setState(() {
                print('data = $data');
                Map<String, dynamic> resultJson = data as Map<String, dynamic>;
                LoginDataModel.instance
                    .fromJson(resultJson['data'] as Map<String, dynamic>);

                print(
                    'LoginDataModel.instance.userId = ${LoginDataModel.instance.userId}');
              });
            },
            error: (ErrorEntity e) {
              print('Error: ${e.message}');
            },
          );
        } catch (e) {
          print('Exception: $e');
        }
      });
  }

  Future<void> wechatAPITest() async {
    try {
      await dio.get<String>('http://localhost:8080/ping').then((r) {
        setState(() {
          print(r.data);
          _text = r.data!.replaceAll(RegExp(r'\s'), '');
        });
      });
    } catch (e) {
      print(e);
    }

    final result = mp.wx.getSystemInfoSync();
    print(result.model);

    mp.wx.login(mp.LoginOption()
      ..success = (result) {
        print('Code = ${result.code}');
        final snackBar = SnackBar(
          content: Text('Code = ${result.code}'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
  }

  void onButtonPressed() {
    // Define what happens when the button is pressed
    print('Button pressed');
  }

  void toMapDemo() {
    Application.navigateTo(context, Routes.mapDemo);
  }

  void toOnBoardingScreen() {
    Application.navigateTo(context, Routes.onBoardingScreen);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = <Widget>[
      SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
              child: CarouselSliderWidget(
                imageUrls: [
                  'https://img-s-msn-com.akamaized.net/tenant/amp/entityid/AA1phtGE.img?w=534&h=334&m=6&x=212&y=31&s=655&d=193',
                  'https://via.placeholder.com/600x400',
                  'https://via.placeholder.com/600x400',
                ],
              ),
            ),
            Center(
              child: Row(
                children: [
                  // 固定展示文案，，主标题，副标题，使用说明按钮 独占一行到解释
                  InfoSection(
                    mainTitle: "心安时刻", 
                    subTitle: "免费科学健康工具 ｜ 使用量： 1000+", 
                    buttonText: "使用说明", 
                    infoText: "心安时刻是一款免费的科学健康工具，帮助用户更好的管理自己的健康。",
                    onButtonPressed: onButtonPressed
                  )
                ],
              ),
            ),
            Column(
              children: [
                // 卡片组件
                CardItem(
                  imageUrl: 'https://via.placeholder.com/150',
                  title: '标题1',
                  description: '这是一个简介1',
                ),
                CardItem(
                  imageUrl: 'https://via.placeholder.com/150',
                  title: '标题2',
                  description: '这是一个简介2',
                ),
                CardItem(
                  imageUrl: 'https://via.placeholder.com/150',
                  title: '标题3',
                  description: '这是一个简介3',
                ),
              ],
            ),
          ],
        ),
      ),
      Center(
        child: Text('我的'),
      )
    ];

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // 使用全局主题颜色
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(widget.title),
      ),
      body: Stack(children: [
        _pages[_selectedIndex],
      ]),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white.withOpacity(0.8),
        elevation: 0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                  color: Colors.white.withOpacity(0.4),
                  width: 1.0,
                ),
              ),
              child: BottomNavigationBar(
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white60,
                backgroundColor: Colors.blue[400],
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    backgroundColor: Colors.white,
                    icon: Icon(Icons.home),
                    label: '主页',
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: Colors.white,
                    icon: Icon(Icons.person),
                    label: '我的',
                  ),
                ],
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
