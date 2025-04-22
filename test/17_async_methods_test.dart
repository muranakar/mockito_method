import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '17_async_methods_test.mocks.dart';

// UserRepositoryクラスのモックを生成するためのアノテーション
@GenerateMocks([UserRepository])
void main() {
  late MockUserRepository mockRepository;

  setUp(() {
    // モックの初期化
    mockRepository = MockUserRepository();
  });

  test('非同期メソッドのモック化', () async {
    // fetchUsers()が呼び出された場合、特定のユーザーリストを非同期で返すように設定
    when(mockRepository.fetchUsers()).thenAnswer(
      (_) async => [User(id: 1, name: '山田太郎')],
    );

    // 検証: fetchUsers()が非空のリストを返すことを確認
    final users = await mockRepository.fetchUsers();
    expect(users, isNotEmpty); // リストが空でないことを確認
    expect(users.first.name, equals('山田太郎')); // 最初のユーザーの名前が"山田太郎"であることを確認
  });

  test('非同期メソッドの例外', () async {
    // fetchUsers()が呼び出された場合、NetworkExceptionをスローするように設定
    when(mockRepository.fetchUsers()).thenThrow(NetworkException());

    // 検証: fetchUsers()が例外をスローすることを確認
    expect(
      () async => await mockRepository.fetchUsers(),
      throwsA(isA<NetworkException>()), // NetworkExceptionがスローされることを確認
    );
  });

  test('Stream型を返すメソッドのモック化', () {
    // getUserStream()が呼び出された場合、特定のユーザーを順番に返すストリームを設定
    when(mockRepository.getUserStream()).thenAnswer(
      (_) => Stream.fromIterable([
        User(id: 1, name: '山田太郎'),
        User(id: 2, name: '佐藤次郎'),
      ]),
    );

    // 検証: getUserStream()が指定された順序でユーザーを返すことを確認
    expect(
      mockRepository.getUserStream(),
      emitsInOrder([
        isA<User>().having((u) => u.name, 'name', '山田太郎'), // 最初のユーザーの名前が"山田太郎"であることを確認
        isA<User>().having((u) => u.name, 'name', '佐藤次郎'), // 次のユーザーの名前が"佐藤次郎"であることを確認
      ]),
    );
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
  Future<List<User>> fetchUsers() async => []; // ユーザーリストを取得するメソッド
  Stream<User> getUserStream() => Stream.empty(); // ユーザーをストリームで取得するメソッド
}

// ネットワーク例外を表すクラス
class NetworkException implements Exception {}
