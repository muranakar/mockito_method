import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '14_timeout_test.mocks.dart';

// モックを生成するためのクラス定義
@GenerateMocks([UserRepository])
void main() {
  late MockUserRepository mockRepository;

  setUp(() {
    mockRepository = MockUserRepository();
  });

  test('timeoutの使用例', () async {
    // モックの振る舞いを設定
    when(mockRepository.getUserById(1)).thenAnswer(
      (_) async => User(id: 1, name: '山田太郎'),
    );

    // 検証のタイムアウトを設定
    await mockRepository.getUserById(1);
    verify(mockRepository.getUserById(1)).called(1);
  });
}

// モック用のクラス
class User {
  final int id;
  final String name;

  User({required this.id, required this.name});
}

class UserRepository {
  Future<User> getUserById(int id) async => User(id: id, name: '');
}
