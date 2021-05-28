import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/constant/Themes.dart';
import 'package:movie_app/widgets/appbar_widget.dart';

void main() {
  testWidgets("Test Appbar Widget", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: AppbarWidget(
            title: "FILM",
            textColor: MyColors.textWhite,
            appbarColor: MyColors.orange)));

    expect(find.text('FILM'), findsOneWidget);

    expect(find.text('filmh'), findsNothing);
  });
}
