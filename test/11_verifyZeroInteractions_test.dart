import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '11_verifyZeroInteractions_test.mocks.dart';

// モックを生成するためのクラス定義
@GenerateMocks([Logger])
void main() {
  late MockLogger mockLogger;

  setUp(() {
    mockLogger = MockLogger();
  });

  test('verifyZeroInteractions()の使用例', () {
    // 相互作用がないことを検証
    verifyZeroInteractions(mockLogger);
  });
}

// モック用のクラス
class Logger {
  void log(String message) {}
}
