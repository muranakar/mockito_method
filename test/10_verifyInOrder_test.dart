import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '10_verifyInOrder_test.mocks.dart';

// モックを生成するためのクラス定義
@GenerateMocks([AuthService, UserRepository, NavigationService])
void main() {
  late MockAuthService mockAuthService;
  late MockUserRepository mockUserRepository;
  late MockNavigationService mockNavigationService;

  setUp(() {
    mockAuthService = MockAuthService();
    mockUserRepository = MockUserRepository();
    mockNavigationService = MockNavigationService();
  });

  test('verifyInOrder()の使用例', () async {
    // モックの振る舞いを設定
    when(mockAuthService.login(any, any)).thenAnswer((_) async {});
    when(mockUserRepository.getUserProfile()).thenAnswer((_) async {});
    when(mockNavigationService.navigateTo(any)).thenAnswer((_) async {});

    // メソッドを呼び出す
    await mockAuthService.login('user@example.com', 'password');
    await mockUserRepository.getUserProfile();
    await mockNavigationService.navigateTo('/home');

    // 呼び出し順序を検証
    verifyInOrder([
      mockAuthService.login('user@example.com', 'password'),
      mockUserRepository.getUserProfile(),
      mockNavigationService.navigateTo('/home')
    ]);
  });
}

// モック用のクラス
class AuthService {
  Future<void> login(String email, String password) async {}
}

class UserRepository {
  Future<void> getUserProfile() async {}
}

class NavigationService {
  Future<void> navigateTo(String route) async {}
}
