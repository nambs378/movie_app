import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/constant/Themes.dart' as Style;

class AppbarWidget extends StatelessWidget {

  final String title;

  const AppbarWidget({Key? key, this.title = "HFILM"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Style.MyColors.appbarColor
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.07,
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.oswald(
                color: Style.MyColors.titleColor,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Divider(
          height: 1,
          color: Style.MyColors.dividerColor,
        )
      ],
    );
  }
}
