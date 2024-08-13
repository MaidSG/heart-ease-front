import 'dart:ui';

import 'package:heart_ease_front/common/components/flutter_flow_model.dart';
import 'package:heart_ease_front/common/components/theme_provider.dart';
import 'package:heart_ease_front/pages/onboarding_screen/onboarding_screen_model.dart';
import 'package:heart_ease_front/public/transfer/circular_progress_page.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;

class OnboardingScreenWidget extends StatefulWidget {
  const OnboardingScreenWidget({super.key, required this.title});

  final String title;

  @override
  State<OnboardingScreenWidget> createState() => _OnboardingScreenWidgetState();
}

class _OnboardingScreenWidgetState extends State<OnboardingScreenWidget> {
  late OnboardingScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  // 屏幕宽度
  late double screenWidth;
  // 加载状态
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OnboardingScreenModel());
    // 保障 组件 已初始化
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

/**
 * 文本组件
 */
  Widget buildTextSection(String text, double screenWidth,
      {EdgeInsetsGeometry? padding, TextStyle? textStyle}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // 基于屏幕宽度调整字体大小
        double responsiveFontSize = screenWidth * 0.04; // 例如，字体大小为屏幕宽度的5%

        // 如果传入的 textStyle 没有指定字体大小，则使用响应式字体大小
        TextStyle effectiveTextStyle = textStyle?.copyWith(
              fontSize: textStyle.fontSize ?? responsiveFontSize,
            ) ??
            TextStyle(
              fontSize: responsiveFontSize, // 动态调整的字体大小
              color: Colors.black, // 默认字体颜色
            );

        return Padding(
          padding: padding ??
              const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 20.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Text(
                  text,
                  textAlign: TextAlign.left,
                  style: effectiveTextStyle,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // 获取屏幕宽度
    screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: ThemeProvider.of(context)!.themeData.primaryColor,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          // 使用全局主题颜色
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          title: Text(
            widget.title,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: _isLoading
            ? CircularProgressPage()
            : Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                      child: SizedBox(
                    width: double.infinity,
                    height: MediaQuery.sizeOf(context).height * 1.0,
                    child: Stack(
                      children: [
                        PageView(
                          controller: _model.pageViewController ??=
                              PageController(initialPage: 0),
                          scrollDirection: Axis.vertical,
                          children: [
                            buildPage(
                              context,
                              screenWidth,
                              '欢迎来到心安 (HeartEase)',
                              'assets/images/English_breakfast-bro.png',
                              '在这里，您将找到心灵的平静与安宁。我们致力于为您提供一个安心舒适的空间，帮助您管理情绪，提升心理健康。',
                              1,
                            ),
                            buildPage(
                              context,
                              screenWidth,
                              '如何使用心安 (HeartEase)',
                              'assets/images/Hotel_Booking-cuate.png',
                              '通过记录心情、正念练习与健康建议，心安帮助您逐步累积心灵财富。我们为您提供简洁的工具，让您更好地理解和管理自己的情绪。',
                              2,
                            ),
                            buildPage(
                              context,
                              screenWidth,
                              '马上开始您的心灵之旅',
                              'assets/images/Load_more-cuate.png',
                              '点击下方开始按钮，立即开启您的心灵安宁之旅。探索心安的独特功能，找到适合您的心灵平衡方式。',
                              null,
                              formButton: ElevatedButton(
                                onPressed: () async {
                                  await _model.pageViewController!
                                      .animateToPage(
                                    0,
                                    duration:
                                        const Duration(milliseconds: 2500),
                                    curve: Curves.ease,
                                  );
                                  setState(() {});
                                },
                                child: const Text(
                                  '开始',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.90, 0.75),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 10.0),
                            child: smooth_page_indicator.SmoothPageIndicator(
                              controller: _model.pageViewController ??=
                                  PageController(initialPage: 0),
                              count: 3,
                              axisDirection: Axis.vertical,
                              onDotClicked: (i) async {
                                await _model.pageViewController!.animateToPage(
                                  i,
                                  duration: const Duration(milliseconds: 2000),
                                  curve: Curves.ease,
                                );
                                setState(() {});
                              },
                              effect: smooth_page_indicator.ExpandingDotsEffect(
                                expansionFactor: 2.0,
                                spacing: 8.0,
                                radius: 16.0,
                                dotWidth: 8.0,
                                dotHeight: 8.0,
                                dotColor:
                                    const Color.fromARGB(153, 107, 101, 101),
                                activeDotColor: Colors.white70,
                                paintStyle: PaintingStyle.fill,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
      ),
    );
  }

  /**
   * 页面组件 单个轮播页
   */
  Widget buildPage(
    BuildContext context,
    double screenWidth,
    String title,
    String imageUrl,
    String description,
    int? pageIndex, {
    ElevatedButton? formButton,
  }) {
    // 如果 int? pageIndex 为 null，则不显示按钮， 否则显示按钮

    return Container(
      width: 100.0,
      height: 100.0,
      color: Colors.lightBlue.shade600,
      decoration: BoxDecoration(
        color: ThemeProvider.of(context)!.themeData.primaryColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, -20.0, 0.0, 5.0),
                child: Image.asset(
                  imageUrl,
                  width: 350.0,
                  height: 400.0,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ],
          ),
          buildTextSection(title, screenWidth,
              textStyle:
                  TextStyle(color: Colors.white, fontSize: screenWidth * 0.05)),
          buildTextSection(description, screenWidth,
              padding:
                  const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 20.0),
              textStyle: const TextStyle(
                color: Colors.white,
              )),
          if (pageIndex == null)
            formButton ?? const SizedBox.shrink()
          else
            Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0), // 设置圆角
                child: BackdropFilter(
                  filter:
                      ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), // 设置模糊效果
                  child: Container(
                    color: Colors.white.withOpacity(0.2), // 设置透明背景
                    child: SizedBox(
                      width: screenWidth * 0.8, // 设置按钮宽度为屏幕宽度的80%
                      height: 50.0, // 设置按钮高度
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent, // 设置按钮背景为透明
                          shadowColor: Colors.transparent, // 去除阴影
                        ),
                        onPressed: () async {
                          await _model.pageViewController!.animateToPage(
                            pageIndex,
                            duration: const Duration(milliseconds: 2500),
                            curve: Curves.ease,
                          );
                          setState(() {});
                        },
                        child: const Text(
                          '下移',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
