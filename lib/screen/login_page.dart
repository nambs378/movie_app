import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/constant/Themes.dart';
import 'package:movie_app/constant/style.dart';
import 'package:movie_app/widgets/background_image.dart';
import 'package:movie_app/widgets/password_input_widget.dart';
import 'package:movie_app/widgets/text_input_widget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(urlImage: "https://cdn.wallpapersafari.com/85/51/cY6q3g.jpg",),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Center(
                      child: Text(
                        'HFILM',
                        style: sHeader,
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 17),
                          child: TextInputWidget(
                            icon: FontAwesomeIcons.solidEnvelope,
                            hint: 'Email',
                            inputType: TextInputType.emailAddress,
                            inputAction: TextInputAction.next,
                            height: 55,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 17,bottom: 10),
                          child: PasswordInput(
                            icon: FontAwesomeIcons.lock,
                            hint: 'Password',
                            inputAction: TextInputAction.done,
                            height: 55,
                          ),
                        ),
                        Text(
                          'Quên mật khẩu?',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          child: _RoundedButton("ĐĂNG NHẬP"),
                        )
                      ],
                    ),
                  )),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Center(
                      child: RichText(
                          text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "Bạn chưa có tài khoản? ",
                            style: TextStyle(
                              color: MyColors.textWhite,
                              fontSize: 16,
                            )),
                        TextSpan(
                            text: "ĐĂNG KÝ",
                            style: TextStyle(
                                color: MyColors.textOrange,
                                decoration: TextDecoration.underline)),
                      ])),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  _RoundedButton(String buttonText) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      child: Material(
        color: MyColors.buttonOrange,
        child: Ink(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: MyColors.buttonOrange),
          child: InkWell(
            onTap: () {},
            splashColor: MyColors.white.withOpacity(0.3),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 55,
              child: Center(
                child: Text(
                  buttonText,
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
    );
  }
}
