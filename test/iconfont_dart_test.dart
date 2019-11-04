import 'package:flutter_test/flutter_test.dart';
import 'package:iconfont_dart/iconfont_dart.dart';

void main() {
  test('params', () {
    IconfontDart(
      '../lib/assets/fonts/demo_index.html', 
      './a.dart'
    );
  });
}
