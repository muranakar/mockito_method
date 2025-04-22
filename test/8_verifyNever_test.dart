import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '8_verifyNever_test.mocks.dart';

// モックを生成するためのクラス定義
@GenerateMocks([AuthService])
void main() {
  late MockAuthService mockAuthService;

  setUp(() {
    mockAuthService = MockAuthService();
  });

  test('verifyNever()の使用例', () {
    // メソッドが呼ばれていないことを検証
    verifyNever(mockAuthService.logout());
  });
}

// モック用のクラス
class AuthService {
  void logout() {}
}
