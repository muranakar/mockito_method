import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '12_reset_test.mocks.dart';

// UserRepositoryクラスのモックを生成するためのアノテーション
@GenerateMocks([UserRepository])
void main() {
  late MockUserRepository mockRepository;

  setUp(() {
    // モックの初期化
    mockRepository = MockUserRepository();
  });

  test('reset()を使用してモックの状態をリセット', () {
    // モックの振る舞いを設定
    // getUserById(1)が呼び出された場合、特定のユーザーを返す
    when(mockRepository.getUserById(1))
        .thenAnswer((_) => Future.value(User(id: 1, name: '山田太郎')));

    // メソッドを呼び出す
    mockRepository.getUserById(1);

    // モックの状態をリセット
    // これにより、モックの振る舞いや記録された相互作用が初期化される
    reset(mockRepository);

    // リセット後は振る舞いが初期化されていることを確認
    // getUserById(1)が呼び出されていないことを検証
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
