// Mocks generated by Mockito 5.1.0 from annotations
// in tw_wallet_ui/test/service/api_provider_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:dio/dio.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:optional/optional.dart' as _i2;
import 'package:tw_wallet_ui/common/http/http_client.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeOptional_0<T> extends _i1.Fake implements _i2.Optional<T> {}

/// A class which mocks [HttpClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i3.HttpClient {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Optional<_i5.Response<dynamic>>> get(String? url,
          {bool? loading = true, bool? throwError = false}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #get, [url], {#loading: loading, #throwError: throwError}),
              returnValue: Future<_i2.Optional<_i5.Response<dynamic>>>.value(
                  _FakeOptional_0<_i5.Response<dynamic>>()))
          as _i4.Future<_i2.Optional<_i5.Response<dynamic>>>);
  @override
  _i4.Future<_i2.Optional<_i5.Response<dynamic>>> post(
          String? url, Map<String, dynamic>? data,
          {bool? loading = true, bool? throwError = false}) =>
      (super.noSuchMethod(
          Invocation.method(
              #post, [url, data], {#loading: loading, #throwError: throwError}),
          returnValue: Future<_i2.Optional<_i5.Response<dynamic>>>.value(
              _FakeOptional_0<_i5.Response<dynamic>>())) as _i4
          .Future<_i2.Optional<_i5.Response<dynamic>>>);
  @override
  _i4.Future<_i2.Optional<_i5.Response<dynamic>>> patch(
          String? url, Map<String, dynamic>? data,
          {bool? loading = true, bool? throwError = false}) =>
      (super.noSuchMethod(
              Invocation.method(#patch, [url, data],
                  {#loading: loading, #throwError: throwError}),
              returnValue: Future<_i2.Optional<_i5.Response<dynamic>>>.value(
                  _FakeOptional_0<_i5.Response<dynamic>>()))
          as _i4.Future<_i2.Optional<_i5.Response<dynamic>>>);
}