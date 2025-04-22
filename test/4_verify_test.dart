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

  test('verify()の使用例', () async {
    // モックの振る舞いを設定
    when(mockRepository.getUserById(1))
        .thenReturn(Future.value(User(id: 1, name: '山田太郎')));

    // メソッドを呼び出す
    await mockRepository.getUserById(1);

    // メソッドが呼ばれたことを検証
    verify(mockRepository.getUserById(1)).called(1);

    // 呼び出し回数の検証バリエーション
    verify(mockRepository.getUserById(1)).called(greaterThan(0));
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
