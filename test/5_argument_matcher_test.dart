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
    // validateEmailがどのような引数でもtrueを返すように設定
    when(mockValidator.validateEmail(any)).thenReturn(true);

    // 特定の条件にマッチ
    // validateEmailが引数に'@'を含む場合にtrueを返すように設定
    when(mockValidator.validateEmail(
            argThat(predicate<String>((email) => email.contains('@')))))
        .thenReturn(true);

    // メソッド呼び出しと検証
    // 'test@example.com'がtrueを返すことを確認
    expect(mockValidator.validateEmail('test@example.com'), isTrue);
    // 'invalid-email'がtrueを返すことを確認
    expect(mockValidator.validateEmail('invalid-email'), isTrue);

    // 引数のキャプチャ
    // validateEmailに渡された引数をキャプチャし、最初の引数が'@'を含むことを確認
    final capturedEmail = verify(mockValidator.validateEmail(captureAny))
        .captured
        .first as String;
    expect(capturedEmail, contains('@'));
  });
}

// モック用のクラス
class Validator {
  bool validateEmail(String email) => email.contains('@');
}
