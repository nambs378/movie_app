import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class TextCustomWidget extends StatelessWidget {
  final String value;
  final double size;
  final Color color;
  final EdgeInsets edgeInsets;
  final bool bold;
  final bool italic;
  final int line;

  TextCustomWidget(
      {Key? key,
      required this.value,
      required this.size,
      required this.color,
      this.edgeInsets = EdgeInsets.zero,
      this.bold = false,
      this.italic = false,
      this.line = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: edgeInsets,
      height: line != 1 ? ((size * 1.1) * line) : null,
      child: Text(
        "$value",
        style: GoogleFonts.roboto(
            color: color,
            fontWeight: (bold) ? FontWeight.bold : null,
            fontSize: size,
            height: 1.1,
            fontStyle: (italic) ? FontStyle.italic : null,),
        maxLines: line,
        overflow: TextOverflow.ellipsis,
        softWrap: true,
      ),
    );
  }
}
