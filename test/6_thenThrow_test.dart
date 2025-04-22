import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '6_thenThrow_test.mocks.dart';

// モックを生成するためのクラス定義
@GenerateMocks([UserRepository])
void main() {
  late MockUserRepository mockRepository;

  setUp(() {
    mockRepository = MockUserRepository();
  });

  test('thenThrow()の使用例', () {
    // 例外をスローするモック
    when(mockRepository.getUserById(99))
        .thenThrow(NotFoundException('ユーザーが見つかりません'));

    // 検証
    expect(() async => await mockRepository.getUserById(99),
        throwsA(isA<NotFoundException>()));
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

class NotFoundException implements Exception {
  final String message;
  NotFoundException(this.message);
}
