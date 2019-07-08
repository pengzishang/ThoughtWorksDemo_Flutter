import 'dart:convert' show json;

class ProfileModel {
  String avatar;
  String nick;
  String profileImage;
  String username;

  ProfileModel.fromParams(
      {this.avatar, this.nick, this.profileImage, this.username});

  factory ProfileModel(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? ProfileModel.fromJson(json.decode(jsonStr))
          : ProfileModel.fromJson(jsonStr);

  ProfileModel.fromJson(jsonRes) {
    nick = jsonRes['nick'];
    profileImage = jsonRes['profile-image'];
    username = jsonRes['username'];
    avatar = jsonRes['avatar'];
  }

  @override
  String toString() {
    return '{"avatar": ${avatar != null ? '${json.encode(avatar)}' : 'null'},"nick": ${nick != null ? '${json.encode(nick)}' : 'null'},"profile-image": ${profileImage != null ? '${json.encode(profileImage)}' : 'null'},"username": ${username != null ? '${json.encode(username)}' : 'null'}}';
  }
}
