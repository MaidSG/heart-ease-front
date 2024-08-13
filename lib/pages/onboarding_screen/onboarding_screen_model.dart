import 'package:heart_ease_front/common/components/flutter_flow_model.dart';
import 'package:heart_ease_front/pages/onboarding_screen/onboarding_screen_widget.dart';
import 'package:flutter/material.dart';

class OnboardingScreenModel extends FlutterFlowModel<OnboardingScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
