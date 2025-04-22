import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '9_verifyNoMoreInteractions_test.mocks.dart';

// モックを生成するためのクラス定義
@GenerateMocks([UserRepository])
void main() {
  late MockUserRepository mockRepository;

  setUp(() {
    mockRepository = MockUserRepository();
  });

  test('verifyNoMoreInteractions()の使用例', () async {
    // モックの振る舞いを設定
    when(mockRepository.getUserById(1))
        .thenAnswer((_) => Future.value(User(id: 1, name: '山田太郎')));

    // メソッドを呼び出す
    await mockRepository.getUserById(1);

    // 必要な検証を行う
    verify(mockRepository.getUserById(1)).called(1);

    // これ以上の相互作用がないことを検証
    verifyNoMoreInteractions(mockRepository);
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
