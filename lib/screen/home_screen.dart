import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/bloc/movie_bloc.dart';
import 'package:movie_app/constant/Themes.dart' as Style;
import 'package:movie_app/constant/constants.dart';
import 'package:movie_app/widgets/appbar_widget.dart';
import 'package:movie_app/widgets/background_image.dart';
import 'package:movie_app/widgets/movie_item.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MovieBloc _movieBloc = MovieBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _movieBloc.getMovie(1, Constants.PER_PAGE);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(),
        Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              child: Column(
                children: [
                  AppbarWidget(),
                  MovieItem(),
                ],
              ),
            )
        ),
        StreamBuilder(
            stream: _movieBloc.loading.stream,
            builder: (context, snapshot) =>  Visibility(
              visible: snapshot.data == true ? true : false,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
        )
      ],
    );
  }
}
