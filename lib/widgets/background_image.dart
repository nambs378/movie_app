import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  final String urlImage;

  const BackgroundImage({Key? key, required this.urlImage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ShaderMask(shaderCallback: (bounds) => LinearGradient(
        colors: [Colors.black, Colors.black12],
        begin: Alignment.bottomCenter,
        end: Alignment.center,
      ).createShader(bounds),
      blendMode: BlendMode.darken,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(urlImage),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken)
            )
        ),
      )
    );
  }
}

