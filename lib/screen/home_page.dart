import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/bloc/movie_bloc.dart';
import 'package:movie_app/constant/Themes.dart' as Style;
import 'package:movie_app/constant/Themes.dart';
import 'package:movie_app/constant/constants.dart';
import 'package:movie_app/constant/my_share_preferences.dart';
import 'package:movie_app/event/movie_event.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/state/movie_state.dart';
import 'package:movie_app/widgets/appbar_widget.dart';
import 'package:movie_app/widgets/background_image.dart';
import 'package:movie_app/widgets/movie_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late MovieBloc _movieBloc = MovieBloc();
  ScrollController _scrollController = ScrollController();
  List<String> favoriteList = [];

  int currentPage = 1;
  int totalPage = 0;
  List<Movie> movieList = [];

  @override
  void initState() {
    super.initState();
    _getMovieFavorite();
    _movieBloc.add(GetMovieList(currentPage, Constants.PER_PAGE));
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("Scroll bottom");
        print(" currentPage : $currentPage, totalPage : $totalPage");
        _getMoreMovie();
      }
    });
  }

  _getMovieFavorite() {
    MySharedPreferences.instance
        .getListStringValue(Constants.PREF_MOVIE_FAVORITE_KEY)
        .then((value) => favoriteList = value);
  }

  _getMoreMovie() {
    if (currentPage < totalPage) {
      print("Get More Movie , currentPage : $currentPage");
      currentPage++;
      _movieBloc.add(GetMovieList(currentPage, Constants.PER_PAGE));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _movieBloc.close();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(urlImage: "https://cdn.wallpapersafari.com/85/51/cY6q3g.jpg",),
        Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
                child: Column(
              children: [
                AppbarWidget(),
                Expanded(
                    child: Container(
                  child: BlocProvider(
                    create: (context) => _movieBloc,
                    child: BlocBuilder<MovieBloc, MovieState>(
                      builder: (context, state) {
                        if (state is MovieStateInitial) {
                          return Container();
                        } else if (state is MovieStateLoading) {
                          if (currentPage == 1) {
                            _movieBloc.loading.add(true);
                          }
                        } else if (state is MovieStateSuccess) {
                          _movieBloc.loading.add(false);
                          List<Movie>? movies = state.movieResponse.listMovie;
                          totalPage = state.movieResponse.paging!.totalPages;
                          if (movies != null) {
                            movieList.addAll(movies);
                          }
                          print(movieList.length.toString());
                        } else if (state is MovieStateError) {
                          movieList.clear();
                          _movieBloc.loading.add(false);
                          return _buildErrorWidget(state.message, context);
                        } else if (state is MovieStateFavorite) {
                          favoriteList = state.favorite;
                        }

                        return Container(
                          child: ListView.builder(
                            controller: _scrollController,
                            padding: EdgeInsets.zero,
                            itemCount: movieList.length + 1,
                            itemBuilder: (context, index) {
                              if (index == movieList.length) {
                                return Visibility(
                                  visible: (currentPage == totalPage &&
                                          currentPage != 1)
                                      ? false
                                      : true,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 100,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                );
                              }
                              return MovieItem(
                                movie: movieList[index],
                                favorited: favoriteList,
                                likeClicked: () {
                                  _movieBloc.add(
                                      SaveMovieFavorite(movieList[index].id));
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ))
              ],
            ))),
        StreamBuilder<bool>(
            stream: _movieBloc.loading.stream,
            builder: (context, snapshot) => Visibility(
                  visible:
                      snapshot.data == true && currentPage == 1 ? true : false,
                  child: Center(
                    child: ProgressDialogPrimary(),
                  ),
                ))
      ],
    );
  }

  _buildErrorWidget(String error, BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Error occured: $error",
          style: TextStyle(color: Colors.white),
        ),
        Container(
            margin: EdgeInsets.only(top: 15),
            child: InkWell(
              onTap: () {
                currentPage = 1;
                _movieBloc.add(GetMovieList(currentPage, Constants.PER_PAGE));
              },
              splashColor: Style.MyColors.white,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: MyColors.buttonOrange),
                child: Center(
                  child: Text(
                    "Try again",
                    style: TextStyle(
                        color: MyColors.textWhite,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ))
      ],
    ));
  }
}

class ProgressDialogPrimary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var brightness =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    ;
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Style.MyColors.orange),
        ),
      ),
      backgroundColor: brightness
          ? Style.MyColors.white.withOpacity(0.40)
          : Style.MyColors.black.withOpacity(
              0.40), // this is the main reason of transparency at next screen. I am ignoring rest implementation but what i have achieved is you can see.
    );
  }
}
