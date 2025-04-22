import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '12_reset_test.mocks.dart';

// モックを生成するためのクラス定義
@GenerateMocks([UserRepository])
void main() {
  late MockUserRepository mockRepository;

  setUp(() {
    mockRepository = MockUserRepository();
  });

  test('reset()の使用例', () {
    // モックの振る舞いを設定
    when(mockRepository.getUserById(1))
        .thenAnswer((_) => Future.value(User(id: 1, name: '山田太郎')));

    // メソッドを呼び出す
    mockRepository.getUserById(1);

    // モックの状態をリセット
    reset(mockRepository);

    // リセット後は振る舞いが初期化されていることを確認
    verifyNever(mockRepository.getUserById(1));
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
