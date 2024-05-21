import 'package:flutter/cupertino.dart';

extension EndScrollExtension on ScrollController {
  bool isEndScroll() =>
      offset >= position.maxScrollExtent && !position.outOfRange;
}
