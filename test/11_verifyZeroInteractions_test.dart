import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '11_verifyZeroInteractions_test.mocks.dart';

// Loggerクラスのモックを生成するためのアノテーション
@GenerateMocks([Logger])
void main() {
  late MockLogger mockLogger;

  setUp(() {
    // モックの初期化
    mockLogger = MockLogger();
  });

  test('verifyZeroInteractions()を使用して相互作用がないことを検証', () {
    // 検証: mockLoggerに対して、どのメソッドも呼び出されていないことを確認
    verifyZeroInteractions(mockLogger);
  });
}

// ログ出力を行うクラス
class Logger {
  void log(String message) {}
}
