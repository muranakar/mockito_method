import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import '1_mock_creation_test.mocks.dart';

// モックを生成するためのクラス定義
@GenerateMocks([HttpClient])
void main() {
  // テストコード
  test('モックの作成テスト', () {
    final mockHttpClient = MockHttpClient();
    expect(mockHttpClient, isNotNull);
  });
}
