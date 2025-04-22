import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '6_thenThrow_test.mocks.dart';

// UserRepositoryクラスをモック化するためのアノテーション
@GenerateMocks([UserRepository])
void main() {
  late MockUserRepository mockRepository;

  setUp(() {
    // モックの初期化
    mockRepository = MockUserRepository();
  });

  test('thenThrow()の使用例', () {
    // モックの振る舞いを設定
    // getUserById(99)が呼び出された場合、NotFoundExceptionをスローする
    when(mockRepository.getUserById(99))
        .thenThrow(NotFoundException('ユーザーが見つかりません'));

    // 検証: getUserById(99)を呼び出した際に、NotFoundExceptionがスローされることを確認
    expect(() async => await mockRepository.getUserById(99),
        throwsA(isA<NotFoundException>()));
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
  Future<User> getUserById(int id) async => User(id: id, name: '');
}

// ユーザーが見つからない場合の例外クラス
class NotFoundException implements Exception {
  final String message;
  NotFoundException(this.message);
}
