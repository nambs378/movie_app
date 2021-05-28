import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/widgets/background_image.dart';
import 'package:network_image_mock/network_image_mock.dart';

main() {
  testWidgets("Test Background image widget", (WidgetTester tester) async {

    await mockNetworkImagesFor(() => tester.pumpWidget(MaterialApp(
          home: BackgroundImage(
            urlImage: "https://cdn.wallpapersafari.com/85/51/cY6q3g.jpg",
          ),
        )));

    var shaderMask = find.byType(ShaderMask);
    expect(shaderMask, findsOneWidget);
    var networkImage =
        (((((tester.firstWidget(find.byType(Container)) as Container)
                    .decoration) as BoxDecoration)
                .image) as DecorationImage)
            .fit;
    expect(networkImage, BoxFit.cover);
  });
}
