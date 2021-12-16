import 'package:flutter/material.dart';
import 'package:image_search_app/data/api.dart';

class PhotoProvider extends InheritedWidget {
  final PixabayApi api;

  const PhotoProvider({
    Key? key,
    required this.api,
    required Widget child,
  }) : super(key: key, child: child);

  static PhotoProvider of(BuildContext context) {
    final PhotoProvider? result =
        context.dependOnInheritedWidgetOfExactType<PhotoProvider>();
    assert(result != null, 'No PixabayApi found in context');
    return result!;
  }

  /* 
    위젯(PhotoProvider)이 변경이 되면 다시 전달을 해주어야 하는데, 그 변경이 됐다라는 규칙을 정하는 부분
    * 이전 상태(oldWidget)과 현재 상태를 비교해야함
  */
  @override
  bool updateShouldNotify(PhotoProvider oldWidget) {
    return oldWidget.api != api; // 이전 상태의 api 와 현재 상태의 api가 다를 경우
  }
}
