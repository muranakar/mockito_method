import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '15_override_behavior_test.mocks.dart';

// UserRepositoryクラスのモックを生成するためのアノテーション
@GenerateMocks([UserRepository])
void main() {
  late MockUserRepository mockRepository;

  setUp(() {
    // モックの初期化
    mockRepository = MockUserRepository();
  });

  test('モックの振る舞いの上書き', () async {
    // 最初の設定: getUserById(1)が呼び出された場合、特定のユーザーを返す
    when(mockRepository.getUserById(1)).thenAnswer(
      (_) => Future.value(User(id: 1, name: '山田太郎')),
    );

    // 検証: 最初の設定が正しく動作することを確認
    expect(await mockRepository.getUserById(1), isA<User>()); // User型を返すことを確認
    expect((await mockRepository.getUserById(1)).name, equals('山田太郎')); // 名前が"山田太郎"であることを確認

    // 振る舞いの上書き: getUserById(1)が呼び出された場合、別のユーザーを返す
    when(mockRepository.getUserById(1)).thenAnswer(
      (_) => Future.value(User(id: 1, name: '山田花子')),
    );

    // 検証: 上書き後の設定が正しく動作することを確認
    expect((await mockRepository.getUserById(1)).name, equals('山田花子')); // 名前が"山田花子"であることを確認
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
