import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '13_clearInteractions_test.mocks.dart';

// UserRepositoryクラスのモックを生成するためのアノテーション
@GenerateMocks([UserRepository])
void main() {
  late MockUserRepository mockRepository;

  setUp(() {
    // モックの初期化
    mockRepository = MockUserRepository();
  });

  test('clearInteractions()の使用例', () {
    // モックの振る舞いを設定
    // getUserById(1)が呼び出された場合、特定のユーザーを非同期で返す
    when(mockRepository.getUserById(1))
        .thenAnswer((_) => Future.value(User(id: 1, name: '山田太郎')));

    // メソッドを呼び出す
    mockRepository.getUserById(1);

    // 相互作用の記録をクリア
    // これにより、モックに対するすべての記録された呼び出しがリセットされる
    clearInteractions(mockRepository);

    // クリア後にgetUserById(1)が呼び出されていないことを確認
    // clearInteractions()が正しく動作しているかを検証
    verifyNever(mockRepository.getUserById(1));
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
