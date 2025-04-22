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
    // addメソッドがどのような引数でも42を返すように設定
    when(mockCalculator.add(any, any)).thenReturn(42);

    // 特定の条件にマッチ
    // addメソッドが最初の引数が10より大きく、2番目の引数が5未満の場合に15を返すように設定
    when(mockCalculator.add(argThat(greaterThan(10)), argThat(lessThan(5))))
        .thenReturn(15);

    // 検証: 任意の値にマッチする場合
    expect(mockCalculator.add(2, 3), equals(42)); // どの引数でも42を返す
    // 検証: 特定の条件にマッチする場合
    expect(mockCalculator.add(11, 3), equals(15)); // 条件に一致する場合15を返す

    // 型マッチャー
    // addメソッドが引数が両方ともint型の場合に100を返すように設定
    when(mockCalculator.add(argThat(isA<int>()), argThat(isA<int>())))
        .thenReturn(100);
    // 検証: 引数がint型の場合
    expect(mockCalculator.add(1, 2), equals(100)); // 両方がint型なら100を返す

    // 等価マッチャー
    // addメソッドが引数が両方とも5の場合に10を返すように設定
    when(mockCalculator.add(argThat(equals(5)), argThat(equals(5))))
        .thenReturn(10);
    // 検証: 引数が5と5の場合
    expect(mockCalculator.add(5, 5), equals(10)); // 両方が5なら10を返す
  });
}

// モック用のクラス
class Calculator {
  int add(int a, int b) => a + b;
}
