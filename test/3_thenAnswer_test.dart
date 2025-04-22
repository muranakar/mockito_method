import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '3_thenAnswer_test.mocks.dart';

// モックを生成するためのクラス定義
@GenerateMocks([Calculator])
void main() {
  late MockCalculator mockCalculator;

  setUp(() {
    mockCalculator = MockCalculator();
  });

  test('thenAnswer()の使用例', () {
    // 引数に応じて動的に値を計算
    when(mockCalculator.add(any, any)).thenAnswer((invocation) {
      final a = invocation.positionalArguments[0] as int;
      final b = invocation.positionalArguments[1] as int;
      return a + b;
    });

    // 検証
    expect(mockCalculator.add(2, 3), equals(5));
    expect(mockCalculator.add(10, 20), equals(30));
  });
}

// モック用のクラス
class Calculator {
  int add(int a, int b) => a + b;
}
