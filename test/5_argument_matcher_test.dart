import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '5_argument_matcher_test.mocks.dart';

// モックを生成するためのクラス定義
@GenerateMocks([Validator])
void main() {
  late MockValidator mockValidator;

  setUp(() {
    mockValidator = MockValidator();
  });

  test('引数マッチャーの使用例', () {
    // 任意の値にマッチ
    when(mockValidator.validateEmail(any)).thenReturn(true);

    // 特定の条件にマッチ
    when(mockValidator.validateEmail(
            argThat(predicate<String>((email) => email.contains('@')))))
        .thenReturn(true);

    // メソッド呼び出し
    expect(mockValidator.validateEmail('test@example.com'), isTrue);
    expect(mockValidator.validateEmail('invalid-email'), isTrue);

    // 引数のキャプチャ
    final capturedEmail = verify(mockValidator.validateEmail(captureAny))
        .captured
        .single as String;
    expect(capturedEmail, contains('@'));
  });
}

// モック用のクラス
class Validator {
  bool validateEmail(String email) => email.contains('@');
}
