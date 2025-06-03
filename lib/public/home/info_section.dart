import 'package:flutter/material.dart';

class InfoSection extends StatelessWidget {
  final String mainTitle;
  final String subTitle;
  final String buttonText;
  final String infoText;
  final VoidCallback onButtonPressed;

  const InfoSection({
    Key? key,
    required this.mainTitle,
    required this.subTitle,
    required this.buttonText,
    required this.infoText,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mainTitle,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  subTitle,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: onButtonPressed,
              child: Text(buttonText),
            ),
          ],
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            infoText,
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
      ],
    );
  }
}