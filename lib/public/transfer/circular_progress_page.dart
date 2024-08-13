


import 'package:flutter/material.dart';

/**
 * 加载页面
 */
class CircularProgressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.lightBlue.shade600,
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
            color: Colors.lightBlue.shade900,
          ),
        ),
      ),
    );
  }
}