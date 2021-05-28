import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/widgets/password_input_widget.dart';

main() {
  testWidgets("Test password input widget", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: PasswordInput(
        icon: FontAwesomeIcons.lock,
        hint: 'Password',
        inputAction: TextInputAction.done,
        height: 55,
      ),
    ));



    var textField = find.byType(TextField);
    expect(textField, findsOneWidget);
    await tester.enterText(textField, 'abcd1234');
    expect(find.text('abcd1234'), findsOneWidget);
    var iconTextField = (((((((tester.firstWidget(textField) as TextField)
                    .decoration) as InputDecoration)
                .prefixIcon) as Padding)
            .child) as Icon)
        .icon;
    expect(iconTextField, FontAwesomeIcons.lock);

    var obscureText = (tester.firstWidget(textField) as TextField)
        .obscureText;
    expect(obscureText, true);

  });
}
