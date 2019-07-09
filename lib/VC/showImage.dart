import 'package:flutter/material.dart';
import 'package:flutter_wechat_demo/Model/TweetModels.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';

class ImagePageView extends StatefulWidget {
  final TweetModel model;
  int selectIndex;

  ImagePageView(this.model, this.selectIndex);
  @override
  _ImagePageViewState createState() => _ImagePageViewState();
}

class _ImagePageViewState extends State<ImagePageView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          bottom: 50,
          right: 0,
          child: DotsIndicator(
            dotsCount: widget.model.images.length,
            position: widget.selectIndex,
            decorator: DotsDecorator(
              color: Colors.grey,
              activeColor: Colors.white,
              size: const Size.square(9.0),
    activeSize: const Size(18.0, 9.0),
    activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
          ),
        ),
        Container(
        color: Colors.black,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: PageView(
            onPageChanged: (index){
              setState(() {
                widget.selectIndex = index;
              });
            },
              controller: PageController(initialPage: widget.selectIndex),
              children: widget.model.images.map((item) {
                return CachedNetworkImage(
                  alignment: Alignment.center,
                  fit: BoxFit.fitWidth,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  imageUrl: item.url,
                );
              }).toList()),
        ),
      ),
      ],
           
    );
  }
}
