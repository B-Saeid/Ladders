import 'dart:convert';
/// TODO : Check if that also throw on web
import 'dart:io' show HandshakeException;

import 'package:http/http.dart' as http;

import '../Extensions/time_package.dart';

enum ContentType {
  applicationJson,
  textHTML;

  String get _value => switch (this) {
        ContentType.applicationJson => 'application/json',
        ContentType.textHTML => 'text/html',
      };

  static const _key = 'Content-Type';
}

class Authorization {
  final String token;
  final bool bearer;
  final bool basic64;

  const Authorization(this.token, {this.bearer = false, this.basic64 = false})
      : assert(bearer == !basic64);

  static String get _key => 'Authorization';

  String get _value {
    if (bearer) return 'Bearer $token';
    if (basic64) {
      final bytes = utf8.encode(token);
      final base64Str = base64.encode(bytes);
      return 'Basic $base64Str';
    }
    return token;
  }
}

abstract class ApiRequest {
  static var _retryFallBack = 0;
  static const _retryIncrement = 2;

  static const errorCaught = 'errorCaught';

  static Future<Map> post({
    required String url,
    // ContentType contentType = ContentType.applicationJson,
    Authorization? authorization,
    Map<String, String>? extraHeaders,
    String? body,
    bool retryOnHandShake = true,
    int retryAttempts = 3,
    Duration? maxWait,
  }) async {
    final headers = extraHeaders ?? ({ContentType._key: ContentType.applicationJson._value});
    authorization != null ? headers.addAll({Authorization._key: authorization._value}) : null;
    extraHeaders != null ? headers.addAll(extraHeaders) : null;
    try {
      http.Response response;
      maxWait != null
          ? response = await http.post(Uri.parse(url), headers: headers, body: body).timeout(
                maxWait,
                onTimeout: () => http.Response('{"Max wait reached": "${maxWait.inSeconds}s"}', 500),
              )
          : response = await http.post(Uri.parse(url), headers: headers, body: body);
      return _checkStatusCode(response, true) as Map;
    } on HandshakeException catch (error) {
      return await _handleHandshake(
        url,
        retryOnHandShake,
        retryAttempts,
        error,
        maxWait: maxWait,
        body: body,
        authorization: authorization,
        inGet: false,
      ) as Map;
    } catch (error) {
      return _handleGenericError(url, error);
    }
  }

  static Future get({
    required String url,
    ContentType contentType = ContentType.applicationJson,
    bool retryOnHandShake = true,
    int retryAttempts = 3,
    Duration? maxWait,
  }) async {
    final headers = <String, String>{};
    headers.addAll({ContentType._key: (contentType._value)});
    final isJson = contentType == ContentType.applicationJson;
    try {
      http.Response response;
      maxWait != null
          ? response = await http.get(Uri.parse(url), headers: headers).timeout(
                maxWait,
                onTimeout: () => http.Response('{"Max wait reached": "${maxWait.inSeconds}s"}', 500),
              )
          : response = await http.get(Uri.parse(url), headers: headers);
      return _checkStatusCode(response, isJson);
    } on HandshakeException catch (error) {
      return await _handleHandshake(
        url,
        retryOnHandShake,
        retryAttempts,
        maxWait: maxWait,
        contentType: contentType,
        error,
        inGet: true,
      );
    } catch (error) {
      return _handleGenericError(url, error);
    }
  }

  /// https://developer.mozilla.org/en-US/docs/Web/HTTP/Status
  // Informational responses (100 – 199)
  // Successful responses (200 – 299)
  // Redirection messages (300 – 399)
  // Client error responses (400 – 499)
  // Server error responses (500 – 599)
  static bool isSuccessful(int code) => (code.clamp(200, 299) == code);

  static dynamic _checkStatusCode(http.Response response, bool isJson) {
    if (isJson) print(response.body);
    print('response.reasonPhrase: >>> ${response.reasonPhrase}');
    final body = isJson ? json.decode(response.body) : response.body;
    if (isSuccessful(response.statusCode) && (isJson ? body is Map : true)) {
      print('Success');
      return body;
    } else {
      print('Failed not 200');
      return {errorCaught: body};
    }
  }

  static Future _handleHandshake(
    String url,
    bool retryOnHandShake,
    int retryAttempts,
    HandshakeException error, {
    Duration? maxWait,
    ContentType? contentType,
    String? body,
    Authorization? authorization,
    required bool inGet,
  }) async {
    print('HandshakeException Occurred in $url ${inGet ? 'get' : 'post'} request ');

    if (retryOnHandShake && _retryFallBack < _retryIncrement * retryAttempts) {
      _retryFallBack += _retryIncrement;
      print('retrying after a $_retryFallBack s ....... ');
      await _retryFallBack.seconds.delay;
      if (inGet) {
        return await get(
          url: url,
          retryOnHandShake: true,
          contentType: contentType!,
          retryAttempts: retryAttempts,
          maxWait: maxWait,
        );
      } else {
        return await post(
          url: url,
          retryAttempts: retryAttempts,
          retryOnHandShake: true,
          body: body,
          authorization: authorization,
          maxWait: maxWait,
        );
      }
    }
    retryOnHandShake
        ? print('retrying is OVER and _retryFallBack = $_retryFallBack s')
        : print('retryOnHandShake is $retryOnHandShake');
    return {errorCaught: error};
  }

  static Map<String, String> _handleGenericError(String url, Object error) {
    print('Error while $url get request Failed due to error : `${error.toString()}');
    print('Error Type is ${error.runtimeType}');
    return {errorCaught: error.toString()};
  }

  static bool errorOccurred(dynamic response) => response is Map && (response[errorCaught] != null);
}
