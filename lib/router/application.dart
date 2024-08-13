
import 'package:heart_ease_front/router/routers.dart';
import 'package:flutter/material.dart';
import 'package:mpflutter_core/mpflutter_core.dart';

/**
 * 声明一个 Application 类，用于保存全局变量
 * 提供全局的路由管理器
 * 使用 Fluro 来替代 Flutter 的基础路由系统
 */
class Application {
  // 封装的路由跳转方法
  static void navigateTo(BuildContext context, String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  // 处理非首页页面的跳转逻辑
  static void handleNavigation(Map query) {
    final navigator = MPNavigatorObserver.currentRoute?.navigator;
    if (navigator != null) {
      final routeName = query["routeName"];
      if (routeName == Routes.mapDemo) {
        navigator.pushNamed(Routes.mapDemo);
      }
      if (routeName == Routes.onBoardingScreen) {
        navigator.pushNamed(Routes.onBoardingScreen);
      }

    }
  }
}
