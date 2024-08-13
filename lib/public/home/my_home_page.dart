import 'package:heart_ease_front/common/components/wechat/wx_button_phone_auth.dart';
import 'package:heart_ease_front/http.dart';
import 'package:heart_ease_front/router/application.dart';
import 'package:heart_ease_front/router/routers.dart';
import 'package:mpflutter_core/mpflutter_core.dart';
import 'package:mpflutter_wechat_api/mpflutter_wechat_api.dart';
import 'package:mpflutter_core/mpjs/mpjs.dart' as mpjs;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _text = '';

  void _incrementCounter() {
    setState(() {
      _counter++;
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

    print('test');
    final result = wx.getSystemInfoSync();
    print(result.model);

    wx.login(LoginOption()
      ..success = (result) {
        final snackBar = SnackBar(
          content: Text('Code = ${result.code}'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
  }

  void toMapDemo() {
    Application.navigateTo(context, Routes.mapDemo);
  }

  void toOnBoardingScreen() {
    Application.navigateTo(context, Routes.onBoardingScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // 使用全局主题颜色
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Text(_text),
              ),
            ),
            ElevatedButton(
              child: const Text('Request'),
              onPressed: () async {
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
              },
            ),
            Container(
                width: 200,
                height: 200,
                color: Colors.red,
                child: WxButtonPhoneAuth()),
            // ElevatedButton(
            //   child: const Text('微信登录'),
            //   onPressed: () async {
            //     wx.login(LoginOption()
            //       ..success = (result) {
            //         final snackBar = SnackBar(
            //           content: Text('Code = ${result.code}'),
            //         );
            //         ScaffoldMessenger.of(context).showSnackBar(snackBar);
            //       });
            //   },
            // ),
            MaterialButton(
              onPressed: () {
                wechatAPITest();
              },
              child: Text('Wechat API Test'),
            ),
            MaterialButton(
              onPressed: () {
                toMapDemo();
              },
              child: Text('Wechat Map Demo'),
            ),
            MaterialButton(
                onPressed: () {
                  toOnBoardingScreen();
                },
                child: Text('Onboarding Screen')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
