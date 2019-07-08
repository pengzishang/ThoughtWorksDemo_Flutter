import 'package:http/http.dart' as http;
import 'package:flutter_wechat_demo/Model/ProfileModel.dart';
import 'package:flutter_wechat_demo/Model/TweetModels.dart';
import 'dart:convert' show json;

class NetworkManger {
  static Future<ProfileModel> getProfileData() async {
    print("1");
    final response = await http
        .get("https://thoughtworks-mobile-2018.herokuapp.com/user/jsmith");
    ProfileModel model = ProfileModel.fromJson(json.decode(response.body));
    return model;
  }

  static Future<TweetModels> getMomentData() async {
    final response = await http.get(
        "https://thoughtworks-mobile-2018.herokuapp.com/user/jsmith/tweets");
    TweetModels model = TweetModels.fromJson(json.decode(response.body));
    return model;
  }
}
