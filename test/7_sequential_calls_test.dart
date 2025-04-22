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

  test('連続した呼び出しの振る舞い', () {
    // 連続して異なる値を返す
    when(mockCounter.getCount()).thenAnswer((_) => 1); // 1回目
    when(mockCounter.getCount()).thenAnswer((_) => 2); // 2回目
    when(mockCounter.getCount()).thenAnswer((_) => 3); // 3回目以降

    // 検証
    expect(mockCounter.getCount(), equals(1));
    expect(mockCounter.getCount(), equals(2));
    expect(mockCounter.getCount(), equals(3));
    expect(mockCounter.getCount(), equals(3)); // 3回目以降は同じ値
  });
}

// モック用のクラス
class Counter {
  int getCount() {
    return 0; // 明示的にintを返す
  }
}
