import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '2_when_thenReturn_test.mocks.dart';

// モックを生成するためのクラス定義
@GenerateMocks([UserRepository])
void main() {
  late MockUserRepository mockRepository;

  setUp(() {
    mockRepository = MockUserRepository();
  });

  test('when()とthenReturn()の使用例', () {
    // getUsers()が呼ばれたとき、特定のユーザーリストを返す
    when(mockRepository.getUsers())
        .thenReturn(Future.value([User(id: 1, name: '山田太郎')]));

    // パラメータ付きメソッドのモック化
    when(mockRepository.getUserById(1))
        .thenReturn(Future.value(User(id: 1, name: '山田太郎')));

    // 検証
    expect(mockRepository.getUsers(), completion(isNotEmpty));
    expect(mockRepository.getUserById(1), completion(isA<User>()));
  });
}

// モック用のクラス
class User {
  final int id;
  final String name;

  User({required this.id, required this.name});
}

class UserRepository {
  Future<List<User>> getUsers() async => [];
  Future<User> getUserById(int id) async => User(id: id, name: '');
}
