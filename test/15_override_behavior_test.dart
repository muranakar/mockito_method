import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '15_override_behavior_test.mocks.dart';

// モックを生成するためのクラス定義
@GenerateMocks([UserRepository])
void main() {
  late MockUserRepository mockRepository;

  setUp(() {
    mockRepository = MockUserRepository();
  });

  test('モックの振る舞いの上書き', () async {
    // 最初の設定
    when(mockRepository.getUserById(1)).thenReturn(
      Future.value(User(id: 1, name: '山田太郎')),
    );

    // 検証
    expect(await mockRepository.getUserById(1), isA<User>());
    expect((await mockRepository.getUserById(1)).name, equals('山田太郎'));

    // 後から上書き
    when(mockRepository.getUserById(1)).thenReturn(
      Future.value(User(id: 1, name: '山田花子')),
    );

    // 上書き後の検証
    expect((await mockRepository.getUserById(1)).name, equals('山田花子'));
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
