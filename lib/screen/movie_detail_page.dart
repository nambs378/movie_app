import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/bloc/detail_bloc.dart';
import 'package:movie_app/constant/Themes.dart';
import 'package:movie_app/constant/style.dart';
import 'package:movie_app/event/detail_event.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/state/detail_state.dart';
import 'package:movie_app/widgets/appbar_widget.dart';
import 'package:movie_app/widgets/background_image.dart';
import 'dart:ui' as ui;
import 'dart:async';

import 'package:movie_app/widgets/text_custom_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailPage extends StatefulWidget {
  static const routeName = '/detail';
  final Movie movie;
  final bool liked;
  const MovieDetailPage({Key? key, required this.movie, required this.liked}) : super(key: key);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late DetailBloc _detailBloc = DetailBloc();
  bool readMore = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _detailBloc.close();
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
        BackgroundImage(urlImage: "https://cdn.wallpapersafari.com/85/51/cY6q3g.jpg",),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            child: BlocProvider(
                create: (context) => _detailBloc,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppbarWidget(
                      title:
                          "${_stringHandle(widget.movie.title, "/")[0].trim()}",
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.all(horizontalScreenPadding),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 40,
                                    child: Container(
                                        margin: EdgeInsets.only(right: horizontalScreenPadding),
                                        child: FutureBuilder<ui.Image>(
                                          future: _getImage(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              ui.Image? image = snapshot.data;
                                              if (image != null) {
                                                return AspectRatio(
                                                  aspectRatio: image.width /
                                                      image.height,
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
                                                      color:
                                                          MyColors.textWhite),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextCustomWidget(
                                                value:
                                                    "${_stringHandle(widget.movie.title, "/").length > 1 ? _stringHandle(widget.movie.title, "/")[1].trim() : _stringHandle(widget.movie.title, "/")[0].trim()}",
                                                size: 17,
                                                color: MyColors.textOrange,
                                                bold: true),
                                            TextCustomWidget(
                                                value:
                                                    "Lượt xem: ${widget.movie.views}",
                                                size: 16,
                                                color: MyColors.textOrange,
                                                edgeInsets:
                                                    EdgeInsets.only(top: 10),
                                                italic: true),
                                            _RichTextCustom(
                                                EdgeInsets.only(top: 15),
                                                "Genres",
                                                widget.movie.category??"empty"),
                                            _RichTextCustom(
                                                EdgeInsets.only(top: 10),
                                                "Actor",
                                                widget.movie.actor??"empty"),
                                            _RichTextCustom(
                                                EdgeInsets.only(top: 10),
                                                "Director",
                                                widget.movie.director??"empty"),
                                            _RichTextCustom(
                                                EdgeInsets.only(top: 10),
                                                "Manufacturer",
                                                widget.movie.manufacturer??"empty"),
                                            _RichTextCustom(
                                                EdgeInsets.only(top: 10),
                                                "Duration",
                                                widget.movie.duration??"empty"),
                                            Container(
                                              margin: EdgeInsets.only(top: 15),
                                              child: Container(
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.anchor_rounded,
                                                      color: widget.liked ?  MyColors.orange : MyColors.white,
                                                      size: 14,
                                                    ),
                                                    TextCustomWidget(
                                                        value: widget.liked  ? "Đã thích" : "Thích",
                                                        size: 14,
                                                        color: widget.liked  ?  MyColors.textOrange : MyColors.textWhite,
                                                        edgeInsets: EdgeInsets.only(left: 3))
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
                                child: BlocBuilder<DetailBloc, DetailState>(
                                  builder: (context, state) {
                                    if (state is DetailStateReadMore) {
                                      readMore = true;
                                    }
                                    return _ReadMoveWidget(
                                        "${widget.movie.description}");
                                  },
                                ),
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
                            margin: EdgeInsets.only(bottom: 10,top: 10),
                            padding: EdgeInsets.symmetric(horizontal: horizontalScreenPadding),
                            child: Divider(
                                color: MyColors.dividerColor, height: 1),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: TextCustomWidget(
                              value: "XEM TRAILER",
                              size: 17,
                              color: MyColors.textOrange,
                              bold: true,
                              edgeInsets: EdgeInsets.only(bottom: 10, left: horizontalScreenPadding),
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
                )),
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
                          _detailBloc.add(ReadMore());
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
