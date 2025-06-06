import 'dart:convert';

import 'package:heart_ease_front/common/components/theme_provider.dart';
import 'package:heart_ease_front/public/home/my_home_page.dart';
import 'package:heart_ease_front/router/application.dart';
import 'package:heart_ease_front/router/routers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:mpflutter_core/mpflutter_core.dart';
import 'package:mpflutter_wechat_api/mpflutter_wechat_api.dart';
import 'package:mpflutter_core/mpjs/mpjs.dart' as mpjs;
import 'package:dio/dio.dart';
import 'http.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  dio.interceptors.add(LogInterceptor());
  runMPApp(const MyApp());

  /**
   * 务必保留这段代码，否则第一次调用 wx 接口会提示异常。
   */
  if (kIsMPFlutter) {
    try {
      wx.$$context$$;
    } catch (e) {}
  }

  /**
   * 使用 AppDelegate 响应应用生命周期事件、分享事件。
   */
  // ignore: unused_local_variable
  final appDelegate = MyAppDelegate();
}

class MyAppDelegate {
  late MPFlutterWechatAppDelegate appDelegate;

  MyAppDelegate() {
    appDelegate = MPFlutterWechatAppDelegate(
      onShow: () {
        print("当应用从后台回到前台，被回调。");
      },
      onHide: () {
        print("当应用从前台切到后台，被回调。");
      },
      onShareAppMessage: (detail) {
        print("当用户点击分享给朋友时，回调，应组装对应的 Map 信息，用于展示和回跳。");
        return onShareAppMessage(detail);
      },
      onLaunch: (query, launchptions) async {
        print(launchptions['path']);
        print("应用冷启动时，会收到回调，应根据 query 决定是否要跳转页面。");
        await Future.delayed(Duration(seconds: 1)); // 加个延时，保障 navigator 已初始化。
        onLaunchOrEnter(query);
      },
      onEnter: (query, launchptions) {
        print("应用热启动（例如用户从分享卡片进入小程序）时，会收到回调，应根据 query 决定是否要跳转页面。");
        onLaunchOrEnter(query);
      },
    );
  }

  /**
   * 存在两种返回 Share Info 的方法
   * - MPFlutterWechatAppShareManager.onShareAppMessage 配合 MPFlutterWechatAppShareManager.setAppShareInfo 使用
   * - 直接返回符合微信小程序要求的 Map
   */
  Map onShareAppMessage(mpjs.JSObject detail) {
    return MPFlutterWechatAppShareManager.onShareAppMessage(detail);
    // final currentRoute = MPNavigatorObserver.currentRoute;
    // if (currentRoute != null) {
    //   final routeName = currentRoute.settings.name;
    //   return {
    //     "title": (() {
    //       if (routeName == "/map_demo") {
    //         return "Map Demo";
    //       } else {
    //         return "Awesome Project";
    //       }
    //     })(),
    //     "path":
    //         "pages/index/index?routeName=${routeName}", // 这个 query 会在 onLaunch 和 onEnter 中带回来。
    //   };
    // } else {
    //   return {};
    // }
  }

  void onLaunchOrEnter(Map query) {
    Application.handleNavigation(query);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      themeData: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Colors.lightBlue.shade100,
          onPrimary: Colors.white,
          secondary: Colors.lightBlue.shade800,
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
        appBarTheme: AppBarTheme(
          color: Colors.lightBlue.shade800,
          foregroundColor: Colors.white,
          elevation: 5.0,
          centerTitle: false,
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
          primaryColor: Colors.lightBlue.shade100,
          appBarTheme: AppBarTheme(
            color: Colors.lightBlue,
            foregroundColor: Colors.white,
            elevation: 5.0,
            centerTitle: false,
          ),
          scaffoldBackgroundColor: Colors.white,
          /**
         * 使用 iOS 风格页面转场
         */
          platform: TargetPlatform.iOS,
        ),
        routes: Routes.getRoutes(),
        home: const MyHomePage(title: 'MPFlutter Awesome Page'),
        /**
       * 务必保留 MPNavigatorObserver，否则小程序的路由会出问题。
       */
        navigatorObservers: [MPNavigatorObserver()],
      ),
      
    );
  }
}
