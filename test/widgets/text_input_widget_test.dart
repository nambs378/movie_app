import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/widgets/text_input_widget.dart';

main() {
  testWidgets("Test text input widget", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: TextInputWidget(
        icon: FontAwesomeIcons.solidEnvelope,
        hint: 'Email',
        inputType: TextInputType.emailAddress,
        inputAction: TextInputAction.next,
        height: 55,
      ),
    ));

    var textField = find.byType(TextField);
    expect(textField, findsOneWidget);
    await tester.enterText(textField, 'email@gmail.com');
    expect(find.text('email@gmail.com'), findsOneWidget);
    var iconTextField = (((((((tester.firstWidget(textField) as TextField).decoration)
                    as InputDecoration)
                .prefixIcon) as Padding)
            .child) as Icon)
        .icon;
    expect(iconTextField, FontAwesomeIcons.solidEnvelope);
  });
}
