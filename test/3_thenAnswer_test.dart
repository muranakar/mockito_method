import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '3_thenAnswer_test.mocks.dart';

// Calculatorクラスをモック化するためのアノテーション
@GenerateMocks([Calculator])
void main() {
  late MockCalculator mockCalculator;

  setUp(() {
    // モックの初期化
    mockCalculator = MockCalculator();
  });

  test('thenAnswer()の使用例', () {
    // モックの振る舞いを設定
    // addメソッドが呼び出された際、引数を使って動的に計算結果を返す
    when(mockCalculator.add(any, any)).thenAnswer((invocation) {
      final a = invocation.positionalArguments[0] as int;
      final b = invocation.positionalArguments[1] as int;
      return a + b;
    });

    // 検証: addメソッドが正しい計算結果を返すことを確認
    expect(mockCalculator.add(2, 3), equals(5)); // 2 + 3 = 5
    expect(mockCalculator.add(10, 20), equals(30)); // 10 + 20 = 30
  });
}

// 実際の計算を行うクラス
class Calculator {
  int add(int a, int b) => a + b;
}
