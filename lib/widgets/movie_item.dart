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
  final List<String> favorited;

  const MovieItem({Key? key, required this.movie, required this.likeClicked, required this.favorited}) : super(key: key);


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
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 31,
                  child: Container(
                      margin: EdgeInsets.only(right: 12),
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
                                style: TextStyle(color: MyColors.textWhite),
                              ),
                            );
                          }
                        },
                      )),
                ),
                Expanded(
                    flex: 69,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextCustomWidget(
                              value: movie.title,
                              size: 14,
                              color: MyColors.textOrange,
                              bold: true),
                          TextCustomWidget(
                              value: movie.title,
                              size: 14,
                              color: MyColors.textWhite,
                              bold: true,
                              edgeInsets: EdgeInsets.only(top: 10)),
                          TextCustomWidget(
                              value: "Lượt xem: ${movie.views}",
                              size: 14,
                              color: MyColors.textWhite,
                              edgeInsets: EdgeInsets.only(top: 10),
                              italic: true),
                          TextCustomWidget(
                              value: "${movie.description}",
                              size: 14,
                              color: MyColors.textWhite,
                              edgeInsets: EdgeInsets.only(top: 15),
                              line: 5),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                ClipRRect(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                                  child: Material(
                                    color: MyColors.buttonOrange.withOpacity(0),

                                    child: Ink(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(3)),
                                      child: InkWell(
                                        onTap: () {
                                          likeClicked();
                                        },
                                        splashColor: MyColors.white.withOpacity(0.3),
                                        child: Container(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.anchor_rounded,
                                                color: liked ?  MyColors.orange : MyColors.white,
                                                size: 14,
                                              ),
                                              TextCustomWidget(
                                                  value: liked  ? "Đã thích" : "Thích",
                                                  size: 14,
                                                  color: liked  ?  MyColors.textOrange : MyColors.textWhite,
                                                  edgeInsets: EdgeInsets.only(left: 3))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  child: Material(
                                    color: MyColors.buttonOrange,

                                    child: Ink(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(3),
                                          color: MyColors.buttonOrange),
                                      child: InkWell(
                                        onTap: () {
                                          print("xem phim clicked");
                                          // Navigator.push(
                                          //     context, MaterialPageRoute(builder: (context) => MovieDetailPage(movie: movie)));
                                          Navigator.pushNamed(context, MovieDetailPage.routeName, arguments: [movie, liked]);
                                        },
                                        splashColor: MyColors.white.withOpacity(0.3),
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width *
                                                  0.3,
                                          height: 30,
                                          child: Center(
                                            child: Text(
                                              "Xem phim",
                                              style: TextStyle(
                                                  color: MyColors.textWhite,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              child: Divider(color: MyColors.dividerColor, height: 1),
            )
          ],
        ));
  }
}
