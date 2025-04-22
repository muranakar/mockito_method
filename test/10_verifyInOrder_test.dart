import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '10_verifyInOrder_test.mocks.dart';

// AuthService, UserRepository, NavigationServiceクラスのモックを生成するためのアノテーション
@GenerateMocks([AuthService, UserRepository, NavigationService])
void main() {
  late MockAuthService mockAuthService;
  late MockUserRepository mockUserRepository;
  late MockNavigationService mockNavigationService;

  setUp(() {
    // 各モックの初期化
    mockAuthService = MockAuthService();
    mockUserRepository = MockUserRepository();
    mockNavigationService = MockNavigationService();
  });

  test('verifyInOrder()を使用してメソッド呼び出しの順序を検証', () async {
    // モックの振る舞いを設定
    // login, getUserProfile, navigateToメソッドが呼び出された際に非同期で成功するように設定
    when(mockAuthService.login(any, any)).thenAnswer((_) async {});
    when(mockUserRepository.getUserProfile()).thenAnswer((_) async {});
    when(mockNavigationService.navigateTo(any)).thenAnswer((_) async {});

    // メソッドを順番に呼び出す
    await mockAuthService.login('user@example.com', 'password');
    await mockUserRepository.getUserProfile();
    await mockNavigationService.navigateTo('/home');

    // 呼び出し順序を検証
    // login → getUserProfile → navigateTo の順序で呼び出されたことを確認
    verifyInOrder([
      mockAuthService.login('user@example.com', 'password'),
      mockUserRepository.getUserProfile(),
      mockNavigationService.navigateTo('/home')
    ]);
  });
}

// ユーザー認証を行うサービスクラス
class AuthService {
  Future<void> login(String email, String password) async {}
}

// ユーザープロファイルを取得するリポジトリクラス
class UserRepository {
  Future<void> getUserProfile() async {}
}

// ナビゲーションを管理するサービスクラス
class NavigationService {
  Future<void> navigateTo(String route) async {}
}
