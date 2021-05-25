import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/widgets/movie_item.dart';

void main() {
  testWidgets("MovieItem", (WidgetTester tester) async {
    Movie movieTest = Movie(
        1,
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

    await tester.pumpWidget(MovieItem(
      movie: movieTest,
      likeClicked: () {},
      favorited: ["2"],
    ));

    expect(find.text('Likeee'), findsOneWidget);

    // final iconFinder = tester.

  });
}
