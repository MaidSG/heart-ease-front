class LoginDataModel {
  LoginDataModel._privateConstructor();

  static final LoginDataModel _instance = LoginDataModel._privateConstructor();

  static LoginDataModel get instance => _instance;

  bool? authenticated;
  List<dynamic>? authorities;
  String? credentials;
  String? jwtToken;
  String? name;
  String? openId;
  String? principal;
  String? sessionKey;
  int? userId;

  void fromJson(Map<String, dynamic> json) {
    authenticated = json['authenticated'];
    authorities = json['authorities'];
    credentials = json['credentials'];
    jwtToken = json['jwtToken'];
    name = json['name'];
    openId = json['openId'];
    principal = json['principal'];
    sessionKey = json['sessionKey'];
    userId = json['userId'];
  }
}
