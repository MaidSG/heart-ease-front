
import 'package:flutter/material.dart';
import 'package:mpflutter_wechat_button/mpflutter_wechat_button.dart';

class WxButtonPhoneAuth extends StatefulWidget {
  const WxButtonPhoneAuth({super.key});

  State<WxButtonPhoneAuth> createState() => _WxButtonState();
  


}


class _WxButtonState extends State<WxButtonPhoneAuth> {
  @override
  Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('WXButton'),
          ),
          body: Center(
            child: MPFlutter_Wechat_Button(

              openType: "getUserInfo",
              onGetUserInfo: (detail) {
                print(detail);
                final snakeBar = SnackBar(
                  content: Row(
                    children: [
                      Text(detail["userInfo"]["nickName"]),
                      
                      // Text(detail["userInfo"]["avatarUrl"]),
                      // Text(detail["userInfo"]["gender"]),
                    ],
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snakeBar);
              },
              child: MaterialButton(
                color: Colors.blue,
                onPressed: () {},
                child: const Text('Get User Info'),
              ),
            ),
          ),
        );
        
      }
}