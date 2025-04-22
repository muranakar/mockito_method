import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '14_timeout_test.mocks.dart';

// UserRepositoryクラスのモックを生成するためのアノテーション
@GenerateMocks([UserRepository])
void main() {
  late MockUserRepository mockRepository;

  setUp(() {
    // モックの初期化
    mockRepository = MockUserRepository();
  });

  test('timeoutの使用例', () async {
    // モックの振る舞いを設定
    // getUserById(1)が呼び出された場合、特定のユーザーを非同期で返す
    when(mockRepository.getUserById(1)).thenAnswer(
      (_) async => User(id: 1, name: '山田太郎'),
    );

    // モックメソッドが正しく呼び出されたことを検証
    // getUserById(1)が1回呼び出されたことを確認
    await mockRepository.getUserById(1);
    verify(mockRepository.getUserById(1)).called(1);
  });
}

// ユーザーデータを表すクラス
class User {
  final int id;
  final String name;

  User({required this.id, required this.name});
}

// ユーザー情報を取得するリポジトリクラス
class UserRepository {
  Future<User> getUserById(int id) async => User(id: id, name: '');
}
