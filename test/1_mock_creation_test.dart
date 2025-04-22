import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import '1_mock_creation_test.mocks.dart';

// @GenerateMocksアノテーションを使用して、HttpClientクラスのモックを生成
// このアノテーションにより、1_mock_creation_test.mocks.dartファイルが自動生成される
@GenerateMocks([HttpClient])
void main() {
  // テストのエントリーポイント
  test('モックの作成テスト', () {
    // MockHttpClientクラスのインスタンスを作成
    // MockHttpClientは自動生成されたHttpClientのモッククラス
    final mockHttpClient = MockHttpClient();

    // モックが正しく作成されたことを確認
    // isNotNullマッチャーを使用して、mockHttpClientがnullでないことを検証
    expect(mockHttpClient, isNotNull);
  });
}
