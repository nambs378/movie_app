import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/constant/Themes.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/widgets/appbar_widget.dart';
import 'package:movie_app/widgets/background_image.dart';
import 'package:movie_app/widgets/read_more_text_widget.dart';
import 'dart:ui' as ui;
import 'dart:async';

import 'package:movie_app/widgets/text_custom_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailPage extends StatefulWidget {
  final Movie movie;

  const MovieDetailPage({Key? key, required this.movie}) : super(key: key);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {

  bool readMore = false;

  @override
  void initState() {
    super.initState();
  }

  List<String> _stringHandle(String value, var pattern) {
    var values = value.split(pattern);
    if (values.length > 1) {
      return values;
    }
    return values;
  }

  @override
  Widget build(BuildContext context) {
    Future<ui.Image> _getImage() {
      Completer<ui.Image> completer = new Completer<ui.Image>();
      new NetworkImage(widget.movie.image)
          .resolve(new ImageConfiguration())
          .addListener(
        ImageStreamListener(
          (ImageInfo image, bool synchronousCall) {
            completer.complete(image.image);
          },
        ),
      );
      return completer.future;
    }

    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: '${_stringHandle(widget.movie.link, "v=")[1].trim()}',
      flags: YoutubePlayerFlags(autoPlay: false),
    );

    return Stack(
      children: [
        BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppbarWidget(
                  title: "${_stringHandle(widget.movie.title, "/")[0].trim()}",
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 40,
                            child: Container(
                                margin: EdgeInsets.only(right: 12),
                                child: FutureBuilder<ui.Image>(
                                  future: _getImage(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      ui.Image? image = snapshot.data;
                                      if (image != null) {
                                        return AspectRatio(
                                          aspectRatio:
                                              image.width / image.height,
                                          child: Container(
                                            color: Colors.black,
                                            child: Image(
                                              image: NetworkImage(
                                                  widget.movie.image),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    } else {
                                      return Center(
                                        child: Text(
                                          'Loading...',
                                          style: TextStyle(
                                              color: MyColors.textWhite),
                                        ),
                                      );
                                    }
                                  },
                                )),
                          ),
                          Expanded(
                              flex: 60,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextCustomWidget(
                                        value:
                                            "${_stringHandle(widget.movie.title, "/").length > 1
                                                ? _stringHandle(widget.movie.title, "/")[1].trim()
                                                : _stringHandle(widget.movie.title, "/")[0].trim()}",
                                        size: 17,
                                        color: MyColors.textOrange,
                                        bold: true),
                                    TextCustomWidget(
                                        value:
                                            "Lượt xem: ${widget.movie.views}",
                                        size: 16,
                                        color: MyColors.textOrange,
                                        edgeInsets: EdgeInsets.only(top: 10),
                                        italic: true),
                                    _RichTextCustom(EdgeInsets.only(top: 15),
                                        "Genres", "${widget.movie.category}"),
                                    _RichTextCustom(EdgeInsets.only(top: 10),
                                        "Actor", "${widget.movie.actor}"),
                                    _RichTextCustom(EdgeInsets.only(top: 10),
                                        "Director", "${widget.movie.director}"),
                                    _RichTextCustom(
                                        EdgeInsets.only(top: 10),
                                        "Manufacturer",
                                        "${widget.movie.manufacturer}"),
                                    _RichTextCustom(EdgeInsets.only(top: 10),
                                        "Duration", "${widget.movie.duration}"),
                                    Container(
                                      margin: EdgeInsets.only(top: 15),
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.anchor_rounded,
                                              color: MyColors.white,
                                              size: 14,
                                            ),
                                            TextCustomWidget(
                                                value: "Thích",
                                                size: 14,
                                                color: MyColors.textWhite,
                                                edgeInsets:
                                                    EdgeInsets.only(left: 3))
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ))
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: _ReadMoveWidget("${widget.movie.description}"),
                      )
                    ],
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.only(left: 12, right: 12),
                        child: Divider(color: MyColors.dividerColor, height: 1),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: TextCustomWidget(
                          value: "XEM TRAILER",
                          size: 17,
                          color: MyColors.textOrange,
                          bold: true,
                          edgeInsets: EdgeInsets.only(bottom: 10, left: 12),
                        ),
                      ),
                      Container(
                        child: YoutubePlayer(
                          controller: _controller,
                          liveUIColor: Colors.amber,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  _ReadMoveWidget(String description) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              "$description",
              style: TextStyle(fontSize: 16, color: MyColors.textWhite),
              maxLines: (readMore) ? 10 : 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          (readMore)
              ? Container()
              : Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    child: SizedBox(
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            readMore = true;
                          });
                        },
                        child: const Text(
                          'Xem thêm',
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: MyColors.textOrange,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}

Widget _RichTextCustom(EdgeInsets edgeInsets, String title, String value) =>
    Container(
      margin: edgeInsets,
      child: RichText(
        text: TextSpan(children: <TextSpan>[
          TextSpan(
              text: "$title: ",
              style: TextStyle(
                  color: MyColors.textWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          TextSpan(
              text: "$value",
              style: TextStyle(
                  color: MyColors.textWhite,
                  fontSize: 14,
                  fontWeight: FontWeight.w300))
        ]),
        maxLines: 2,
      ),
    );
