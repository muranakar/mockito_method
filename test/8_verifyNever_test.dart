import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '8_verifyNever_test.mocks.dart';

// AuthServiceクラスのモックを生成するためのアノテーション
@GenerateMocks([AuthService])
void main() {
  late MockAuthService mockAuthService;

  setUp(() {
    // モックの初期化
    mockAuthService = MockAuthService();
  });

  test('verifyNever()を使用してメソッドが呼び出されていないことを検証', () {
    // logoutメソッドが一度も呼び出されていないことを確認
    verifyNever(mockAuthService.logout());
  });
}

// 実際のサービスクラス
class AuthService {
  // ユーザーをログアウトするメソッド
  void logout() {}
}
