import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '2_when_thenReturn_test.mocks.dart';

// UserRepositoryクラスをモック化するためのアノテーション
@GenerateMocks([UserRepository])
void main() {
  late MockUserRepository mockRepository;

  setUp(() {
    // モックの初期化
    mockRepository = MockUserRepository();
  });

  test('when()とthenAnswer()の使用例', () {
    // getUsers()が呼ばれたとき、特定のユーザーリストを非同期で返すように設定
    when(mockRepository.getUsers())
        .thenAnswer((_) => Future.value([User(id: 1, name: '山田太郎')]));

    // getUserById()が特定のIDで呼ばれたとき、対応するユーザーを非同期で返すように設定
    when(mockRepository.getUserById(1))
        .thenAnswer((_) => Future.value(User(id: 1, name: '山田太郎')));

    // モックの動作を検証
    // getUsers()が非空のリストを返すことを確認
    expect(mockRepository.getUsers(), completion(isNotEmpty));
    // getUserById(1)がUser型のインスタンスを返すことを確認
    expect(mockRepository.getUserById(1), completion(isA<User>()));
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
  Future<List<User>> getUsers() async => [];
  Future<User> getUserById(int id) async => User(id: id, name: '');
}
