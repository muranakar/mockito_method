import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '16_matchers_test.mocks.dart';

// モックを生成するためのクラス定義
@GenerateMocks([Calculator])
void main() {
  late MockCalculator mockCalculator;

  setUp(() {
    mockCalculator = MockCalculator();
  });

  test('Matchersの使用例', () {
    // 任意の値にマッチ
    when(mockCalculator.add(any, any)).thenReturn(42);

    // 特定の条件にマッチ
    when(mockCalculator.add(argThat(greaterThan(10)), argThat(lessThan(5))))
        .thenReturn(15);

    // 検証
    expect(mockCalculator.add(2, 3), equals(42)); // 任意の値にマッチ
    expect(mockCalculator.add(11, 3), equals(15)); // 条件にマッチ

    // 型マッチャー
    when(mockCalculator.add(argThat(isA<int>()), argThat(isA<int>())))
        .thenReturn(100);
    expect(mockCalculator.add(1, 2), equals(100));

    // 等価マッチャー
    when(mockCalculator.add(argThat(equals(5)), argThat(equals(5))))
        .thenReturn(10);
    expect(mockCalculator.add(5, 5), equals(10));
  });
}

// モック用のクラス
class Calculator {
  int add(int a, int b) => a + b;
}
