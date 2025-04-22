import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '4_verify_test.mocks.dart';

// モックを生成するためのクラス定義
@GenerateMocks([UserRepository])
void main() {
  late MockUserRepository mockRepository;

  setUp(() {
    mockRepository = MockUserRepository();
  });

  test('verify()とverifyNever()の使用例', () async {
    // モックの振る舞いを設定
    // getUserById(1)が呼び出された場合、特定のユーザーを返す
    when(mockRepository.getUserById(1))
        .thenAnswer((_) => Future.value(User(id: 1, name: '山田太郎')));

    // メソッドを呼び出す
    await mockRepository.getUserById(1);

    // 検証: getUserById(1)が1回呼び出されたことを確認
    verify(mockRepository.getUserById(1)).called(1);

    // 検証: getUserById(2)が一度も呼び出されていないことを確認
    verifyNever(mockRepository.getUserById(2));
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
