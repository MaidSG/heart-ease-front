import 'package:heart_ease_front/pages/onboarding_screen/onboarding_screen_widget.dart';
import 'package:heart_ease_front/public/home/my_home_page.dart';
import 'package:flutter/material.dart';

/**
 * 路由路径常量化
 */
class Routes {
  static String root = "/";
  static String mapDemo = "/map_demo";
  static String onBoardingScreen = "/on_boarding_screen";

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      root: (context) => const MyHomePage(title: '心安(HeartEase)'),
      mapDemo: (context) => const MyHomePage(title: 'map_demo Page'),
      onBoardingScreen: (context) => const OnboardingScreenWidget(title:'心安介绍'),
    };
  }
}
