import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/screen/home_page.dart';
import 'package:movie_app/screen/movie_detail_page.dart';
import 'package:movie_app/widgets/movie_item.dart';
import 'package:network_image_mock/network_image_mock.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

main() {
  testWidgets("Test Movie item widget", (WidgetTester tester) async {
    final mockObserver = MockNavigatorObserver();

    bool testLikeTap = false;
    bool testItemTap = false;

    Movie movieTest = Movie(
        3,
        "DON'T BREATHE / SÁT NHÂN TRONG BÓNG TỐI",
        "http://training-movie.bsp.vn:82/upload/movie/sdasdasda.jpg",
        "https://www.youtube.com/watch?v=TRusW3VPLaI",
        "Ba tên trộm liều lĩnh đột nhập vào nhà một người đàn ông giàu có bị mù."
            " Lũ trộm cho rằng bản thân sẽ vớ bở, thế nhưng chúng đã sai. Trong "
            "bóng tối, kẻ mù làm vua. Người đàn ông tưởng chừng yếu đuối nay lại "
            "trở thành ác quỷ đưa bọn chúng xuống địa ngục.",
        "Kinh dị, Hành động",
        "Daniel Zovatto, Jane Levy",
        "Fede Alvarez",
        "Sony Pictures",
        "88",
        "2016-08-30",
        "2016-08-30 15:45:37",
        "0000-00-00 00:00:00",
        483,
        "showing");

    var favoriteList = ["2", "5", "3"];

    await mockNetworkImagesFor(() async => await tester.pumpWidget(MaterialApp(
          navigatorObservers: [mockObserver],
          home: MovieItem(
            movie: movieTest,
            favorited: favoriteList,
            likeClicked: () {
              testLikeTap = !testLikeTap;
            },
            itemClicked: () {
              testItemTap = !testItemTap;
            },
          ),
        )));

    expect(
        find.text("DON'T BREATHE / SÁT NHÂN TRONG BÓNG TỐI"), findsOneWidget);

    var inkWell = find.byType(InkWell);
    expect(inkWell, findsWidgets);

    var inkWellFavorite = find.byKey(Key('inkwell_favorite'));
    //test click favorite button
    await tester.tap(inkWellFavorite, pointer: 1);
    await tester.pump(const Duration(seconds: 1));
    expect(testLikeTap, equals(true));
    //test double click favorite button
    await tester.tap(inkWellFavorite, pointer: 2);
    await tester.pump(const Duration(seconds: 1));
    expect(testLikeTap, equals(false));

    var inkWellNavigationPush = find.byKey(Key('inkwell_navigation_push'));
    await tester.tap(inkWellNavigationPush, pointer: 1);
    await tester.pump(const Duration(seconds: 1));
    expect(testItemTap, equals(true));
  });
}
