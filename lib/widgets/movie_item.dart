import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/constant/Themes.dart';

class MovieItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(15),
        height: 350,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 36,
                  child: Container(
                    margin: EdgeInsets.only(right: 15),
                    height: 150,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: NetworkImage(
                          "https://cdn.wallpapersafari.com/96/17/1o9fX8.jpg"),
                      fit: BoxFit.fill,
                    )),
                  ),
                ),
                Expanded(
                    flex: 64,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _TextCustom("SENSE 8", 14, MyColors.textOrange,
                              bold: true),
                          _TextCustom("Sieu giac quan", 14, MyColors.textWhite,
                              bold: true, edgeInsets: EdgeInsets.only(top: 10)),
                          _TextCustom(
                              "Luot xem: 666.999", 14, MyColors.textWhite,
                              edgeInsets: EdgeInsets.only(top: 10),
                              italic: true),
                          _TextCustom(
                              "https://cdn.wallpapersafari.com/9https://cdnhttps://cdn.wallpapersafari.com/96.wallpapersafari.com/96https://cdn.wallpapersafari.com/966/",
                              14,
                              MyColors.textWhite,
                              edgeInsets: EdgeInsets.only(top: 7),
                              line: 5),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.anchor_rounded,
                                        color: MyColors.white,
                                        size: 14,
                                      ),
                                      _TextCustom(
                                          "Thich", 14, MyColors.textWhite,
                                          edgeInsets: EdgeInsets.only(left: 3))
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: MyColors.buttonOrange),
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
              margin: EdgeInsets.only(top: 10),
              child: Divider(color: MyColors.dividerColor, height: 1),
            )
          ],
        ));
  }
}

Widget _TextCustom(String value, double size, Color color,
    {EdgeInsets edgeInsets = EdgeInsets.zero,
    bool bold = false,
    bool italic = false,
    int line = 1}) {
  return Container(
    margin: edgeInsets,
    height: line != 1 ? (size * line) : null,
    child: Text(
      value,
      style: GoogleFonts.roboto(
          color: color,
          fontWeight: (bold) ? FontWeight.bold : null,
          fontSize: size,
          height: 1,
          fontStyle: (italic) ? FontStyle.italic : null),
      maxLines: line,
      overflow: TextOverflow.ellipsis,
      softWrap: true,
    ),
  );
}
