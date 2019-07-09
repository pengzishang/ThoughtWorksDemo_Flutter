import 'package:flutter/material.dart';
import 'package:flutter_wechat_demo/Model/ProfileModel.dart';
import 'package:flutter_wechat_demo/Model/TweetModels.dart';
import 'package:flutter_wechat_demo/VC/showImage.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_wechat_demo/Network/NetworkManger.dart';

class MomentPage extends StatefulWidget {
  @override
  _MomentPageState createState() => _MomentPageState();
}

class _MomentPageState extends State<MomentPage> {
  bool showTop = false;
  ScrollController _controller = new ScrollController();
  ProfileModel profileData;
  TweetModels tweetModels;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.offset < 225) {
        setState(() {
          showTop = false;
        });
      } else if (_controller.offset >= 225) {
        setState(() {
          showTop = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      controller: _controller,
      headerSliverBuilder: (BuildContext context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.add_a_photo,
                    color: showTop ? Colors.black : Colors.white,
                  ),
                  onPressed: () {},
                )
              ],
              brightness: !showTop ? Brightness.dark : Brightness.light,
              expandedHeight: 280,
              pinned: true,
              iconTheme:
                  IconThemeData(color: !showTop ? Colors.white : Colors.black),
              backgroundColor: showTop ? Colors.white : Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "朋友圈",
                  style: TextStyle(
                      color: showTop ? Colors.black : Colors.transparent),
                ),
                background: buileWidget(),
              ))
        ];
      },
      body: FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (this.tweetModels == null) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            tweetModels = snapshot.data;
          }

          return SafeArea(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    ListItem(this.tweetModels.list[index]),
                    Divider()
                  ],
                );
              },
              itemCount: tweetModels.list.length,
            ),
          );
        },
        future: NetworkManger.getMomentData(),
      ),
    ));
  }

  Widget buileWidget() {
    if (this.profileData != null) {
      return buildStack();
    } else {
      return buildFutureBuilder();
    }
  }

  FutureBuilder<ProfileModel> buildFutureBuilder() {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (this.profileData == null) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          profileData = snapshot.data;
        }
        return buildStack();
      },
      future: buildProfileData(),
    );
  }

  Stack buildStack() {
    return Stack(
      children: <Widget>[
        CachedNetworkImage(
          alignment: Alignment.topCenter,
          fit: BoxFit.fitWidth,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          imageUrl: this.profileData.profileImage,
        ),
        Positioned(
          width: 80,
          height: 80,
          bottom: 00,
          right: 20,
          child: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 0.5, color: Colors.black)),
            child: Container(
              child: CachedNetworkImage(
                alignment: Alignment.topCenter,
                fit: BoxFit.fitWidth,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                imageUrl: this.profileData.avatar,
              ),
            ),
          ),
        )
      ],
    );
  }

  Future<ProfileModel> buildProfileData() {
    if (this.profileData != null) {
      return Future.value(profileData);
    } else {
      return NetworkManger.getProfileData();
    }
  }
}

class ListItem extends StatelessWidget {
  final TweetModel model;
  ListItem(this.model);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            //头像
            margin: EdgeInsets.only(right: 10),
            width: 40,
            height: 40,
            child: CachedNetworkImage(
              alignment: Alignment.topCenter,
              fit: BoxFit.fitWidth,
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              imageUrl: this.model.sender.avatar,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(model.sender.username),
                SizedBox(
                  height: 8,
                ),
                Text(
                  model.content,
                ),
                buildGridView(context),
                buildListView(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildListView() {
    if (this.model.comments == null || this.model.comments.length == 0) {
      return SizedBox(
        height: 0,
      );
    }
    return Container(
      margin: EdgeInsets.only(top: 16, right: 10, bottom: 0),
      padding: EdgeInsets.only(left: 10, top: 5, right: 5, bottom: 5),
      color: Colors.grey[300],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: model.comments
            .map((item) => Container(
                padding: EdgeInsets.only(top: 2, bottom: 2),
                child: Text(item.sender.username + ": " + item.content)))
            .toList(),
      ),
    );
  }

  Widget buildGridView(BuildContext context) {
    if (this.model.images == null || this.model.images.length == 0) {
      return SizedBox(
        height: 0,
      );
    } else {
      return Container(
        margin: EdgeInsets.only(top: 10, right: 10, bottom: 0),
        height: heightbuilder(),
        child: GridView.extent(
          physics: NeverScrollableScrollPhysics(),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          maxCrossAxisExtent: 100.0,
          children: model.images.map((item) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return ImagePageView(this.model,model.images.indexOf(item));
                }));
              },
              child: CachedNetworkImage(
                alignment: Alignment.center,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                imageUrl: item.url,
              ),
            );
          }).toList(),
        ),
      );
    }
  }

  double heightbuilder() {
    int row = ((model.images.length - 1) / 3 + 1).toInt();
    return row * (100).toDouble() + (row - 1) * 16.toDouble();
  }
}
