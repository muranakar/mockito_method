import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '17_async_methods_test.mocks.dart';

// モックを生成するためのクラス定義
@GenerateMocks([UserRepository])
void main() {
  late MockUserRepository mockRepository;

  setUp(() {
    mockRepository = MockUserRepository();
  });

  test('非同期メソッドのモック化', () async {
    // Future型を返すメソッドのモック化
    when(mockRepository.fetchUsers()).thenAnswer(
      (_) async => [User(id: 1, name: '山田太郎')],
    );

    // 検証
    final users = await mockRepository.fetchUsers();
    expect(users, isNotEmpty);
    expect(users.first.name, equals('山田太郎'));
  });

  test('非同期メソッドの例外', () async {
    // 例外をスローするモック
    when(mockRepository.fetchUsers()).thenThrow(NetworkException());

    // 検証
    expect(
      () async => await mockRepository.fetchUsers(),
      throwsA(isA<NetworkException>()),
    );
  });

  test('Stream型を返すメソッドのモック化', () {
    // Stream型を返すメソッドのモック化
    when(mockRepository.getUserStream()).thenAnswer(
      (_) => Stream.fromIterable([
        User(id: 1, name: '山田太郎'),
        User(id: 2, name: '佐藤次郎'),
      ]),
    );

    // 検証
    expect(
      mockRepository.getUserStream(),
      emitsInOrder([
        isA<User>().having((u) => u.name, 'name', '山田太郎'),
        isA<User>().having((u) => u.name, 'name', '佐藤次郎'),
      ]),
    );
  });
}

// モック用のクラス
class User {
  final int id;
  final String name;

  User({required this.id, required this.name});
}

class UserRepository {
  Future<List<User>> fetchUsers() async => [];
  Stream<User> getUserStream() => Stream.empty();
}

class NetworkException implements Exception {}
