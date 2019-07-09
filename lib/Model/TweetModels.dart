import 'dart:convert' show json;

class TweetModels {
  List<TweetModel> list;

  TweetModels.fromParams({this.list});

  factory TweetModels(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new TweetModels.fromJson(json.decode(jsonStr))
          : new TweetModels.fromJson(jsonStr);

  TweetModels.fromJson(jsonRes) {
    list = jsonRes == null ? null : [];

    for (var listItem in list == null ? [] : jsonRes) {
      list.add(listItem == null ? null : new TweetModel.fromJson(listItem));
    }
    list = list.where((test) {
      return (test.error == null && test.unknownError == null);
    }).toList();
  }

  @override
  String toString() {
    return '{"json_list": $list}';
  }
}

class TweetModel {
  String content;
  String error;
  String unknownError;
  List<TweetComment> comments;
  List<TweetImage> images;
  TweetSender sender;

  TweetModel.fromParams(
      {this.content,
      this.error,
      this.unknownError,
      this.comments,
      this.images,
      this.sender});

  TweetModel.fromJson(jsonRes) {
    content = jsonRes['content'];
    if (content == null) {
      content = '';
    }
    error = jsonRes['error'];
    unknownError = jsonRes['unknown error'];
    comments = jsonRes['comments'] == null ? null : [];

    for (var commentsItem in comments == null ? [] : jsonRes['comments']) {
      comments.add(commentsItem == null
          ? null
          : new TweetComment.fromJson(commentsItem));
    }

    images = jsonRes['images'] == null ? null : [];

    for (var imagesItem in images == null ? [] : jsonRes['images']) {
      images
          .add(imagesItem == null ? null : new TweetImage.fromJson(imagesItem));
    }

    sender = jsonRes['sender'] == null
        ? null
        : new TweetSender.fromJson(jsonRes['sender']);
  }

  @override
  String toString() {
    return '{"content": ${content != null ? '${json.encode(content)}' : 'null'},"error": ${error != null ? '${json.encode(error)}' : 'null'},"unknown error": ${unknownError != null ? '${json.encode(unknownError)}' : 'null'},"comments": $comments,"images": $images,"sender": $sender}';
  }
}

class TweetSender {
  String avatar;
  String nick;
  String username;

  TweetSender.fromParams({this.avatar, this.nick, this.username});

  TweetSender.fromJson(jsonRes) {
    avatar = jsonRes['avatar'];
    nick = jsonRes['nick'];
    username = jsonRes['username'];
  }

  @override
  String toString() {
    return '{"avatar": ${avatar != null ? '${json.encode(avatar)}' : 'null'},"nick": ${nick != null ? '${json.encode(nick)}' : 'null'},"username": ${username != null ? '${json.encode(username)}' : 'null'}}';
  }
}

class TweetImage {
  String url;

  TweetImage.fromParams({this.url});

  TweetImage.fromJson(jsonRes) {
    url = jsonRes['url'];
  }

  @override
  String toString() {
    return '{"url": ${url != null ? '${json.encode(url)}' : 'null'}}';
  }
}

class TweetComment {
  String content;
  CommentSender sender;

  TweetComment.fromParams({this.content, this.sender});

  TweetComment.fromJson(jsonRes) {
    content = jsonRes['content'];
    // content += 'ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd';
    sender = jsonRes['sender'] == null
        ? null
        : new CommentSender.fromJson(jsonRes['sender']);
  }

  @override
  String toString() {
    return '{"content": ${content != null ? '${json.encode(content)}' : 'null'},"sender": $sender}';
  }
}

class CommentSender {
  String avatar;
  String nick;
  String username;

  CommentSender.fromParams({this.avatar, this.nick, this.username});

  CommentSender.fromJson(jsonRes) {
    avatar = jsonRes['avatar'];
    nick = jsonRes['nick'];
    username = jsonRes['username'];
  }

  @override
  String toString() {
    return '{"avatar": ${avatar != null ? '${json.encode(avatar)}' : 'null'},"nick": ${nick != null ? '${json.encode(nick)}' : 'null'},"username": ${username != null ? '${json.encode(username)}' : 'null'}}';
  }
}
