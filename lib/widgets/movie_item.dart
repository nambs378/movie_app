import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/constant/Themes.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/screen/movie_detail_page.dart';
import 'package:movie_app/widgets/text_custom_widget.dart';
import 'dart:ui' as ui;
import 'dart:async';

class MovieItem extends StatelessWidget {
  final Movie movie;
  final Function likeClicked;
  final Function itemClicked;
  final List<String> favorited;

  const MovieItem(
      {Key? key,
      required this.movie,
      required this.likeClicked,
      required this.favorited,
      required this.itemClicked})
      : super(key: key);

  Future<ui.Image> _getImage() {
    Completer<ui.Image> completer = new Completer<ui.Image>();
    new NetworkImage(movie.image).resolve(new ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo image, bool synchronousCall) {
          completer.complete(image.image);
        },
      ),
    );
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    bool liked = (favorited.contains(movie.id.toString()));
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      child: Material(
        color: MyColors.buttonOrange.withOpacity(0),
        child: Ink(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(3)),
          child: InkWell(
              key: Key('inkwell_navigation_push'),
              onTap: () {
                itemClicked();

              },
              splashColor: MyColors.orange.withOpacity(0.5),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        padding: EdgeInsets.symmetric(vertical: 20),
                        width: MediaQuery.of(context).size.width,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.62,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextCustomWidget(
                                    value: movie.title,
                                    size: 15,
                                    color: MyColors.black,
                                    bold: true),
                                TextCustomWidget(
                                    value: "${movie.description}",
                                    size: 13,
                                    color: MyColors.textGray,
                                    edgeInsets: EdgeInsets.only(top: 7),
                                    line: 3),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.remove_red_eye_rounded,
                                              color: MyColors.orange,
                                              size: 13,
                                            ),
                                            TextCustomWidget(
                                                value: "${movie.views}",
                                                size: 13,
                                                color: MyColors.textGray,
                                                edgeInsets:
                                                    EdgeInsets.only(left: 3)),
                                          ],
                                        ),
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        child: Container(
                                          width: 70,
                                          alignment: Alignment.centerLeft,
                                          child: Material(
                                            color: MyColors.buttonOrange
                                                .withOpacity(0),
                                            child: Ink(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(3)),
                                              child: InkWell(
                                                key: Key('inkwell_favorite'),
                                                onTap: () {
                                                  likeClicked();
                                                },
                                                splashColor: MyColors.white
                                                    .withOpacity(0.3),
                                                child: Container(
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        liked
                                                            ? Icons.favorite
                                                            : Icons
                                                                .favorite_outline,
                                                        color: MyColors.orange,
                                                        size: 13,
                                                      ),
                                                      Flexible(
                                                        child: TextCustomWidget(
                                                            value: liked
                                                                ? "Liked"
                                                                : "Like",
                                                            size: 13,
                                                            color: liked
                                                                ? MyColors
                                                                    .textOrange
                                                                : MyColors
                                                                    .textGray,
                                                            edgeInsets:
                                                                EdgeInsets.only(
                                                                    left: 3)),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: MediaQuery.of(context).size.width * 0.3,
                          padding: EdgeInsets.only(right: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            child: Container(
                                child: FutureBuilder<ui.Image>(
                              future: _getImage(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  ui.Image? image = snapshot.data;
                                  if (image != null) {
                                    return AspectRatio(
                                      aspectRatio: image.width / image.height,
                                      child: Container(
                                        color: Colors.black,
                                        child: Image(
                                          image: NetworkImage(movie.image),
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
                                      style:
                                          TextStyle(color: MyColors.textWhite),
                                    ),
                                  );
                                }
                              },
                            )),
                          ),
                        ),
                      ),
                    ],
                  ))),
        ),
      ),
    );
  }
}
