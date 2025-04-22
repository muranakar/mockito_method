import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '9_verifyNoMoreInteractions_test.mocks.dart';

// UserRepositoryクラスのモックを生成するためのアノテーション
@GenerateMocks([UserRepository])
void main() {
  late MockUserRepository mockRepository;

  setUp(() {
    // モックの初期化
    mockRepository = MockUserRepository();
  });

  test('verifyNoMoreInteractions()を使用して追加の相互作用がないことを検証', () async {
    // モックの振る舞いを設定
    // getUserById(1)が呼び出された場合、特定のユーザーを返す
    when(mockRepository.getUserById(1))
        .thenAnswer((_) => Future.value(User(id: 1, name: '山田太郎')));

    // メソッドを呼び出す
    await mockRepository.getUserById(1);

    // 検証: getUserById(1)が1回呼び出されたことを確認
    verify(mockRepository.getUserById(1)).called(1);

    // 検証: これ以上の相互作用がないことを確認
    verifyNoMoreInteractions(mockRepository);
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
