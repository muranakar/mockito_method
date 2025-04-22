import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '7_sequential_calls_test.mocks.dart';

// モックを生成するためのクラス定義
@GenerateMocks([Counter])
void main() {
  late MockCounter mockCounter;

  setUp(() {
    mockCounter = MockCounter();
  });

  test('連続した呼び出しの振る舞いを確認', () {
    // モックのメソッドが連続して呼び出された際に異なる値を返すように設定
    int callCount = 0;
    when(mockCounter.getCount()).thenAnswer((_) {
      callCount++;
      if (callCount == 1) return 1; // 最初の呼び出しでは1を返す
      if (callCount == 2) return 2; // 2回目の呼び出しでは2を返す
      return 3; // 3回目以降の呼び出しでは3を返す
    });

    // 検証: 1回目の呼び出しで1が返されることを確認
    expect(mockCounter.getCount(), equals(1));
    // 検証: 2回目の呼び出しで2が返されることを確認
    expect(mockCounter.getCount(), equals(2));
    // 検証: 3回目の呼び出しで3が返されることを確認
    expect(mockCounter.getCount(), equals(3));
    // 検証: 4回目以降の呼び出しでも3が返されることを確認
    expect(mockCounter.getCount(), equals(3));
  });
}

// モック用のクラス
class Counter {
  int getCount() {
    return 0; // 明示的にintを返す
  }
}
