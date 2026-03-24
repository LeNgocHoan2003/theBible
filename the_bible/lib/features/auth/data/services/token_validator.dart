import 'dart:convert';

class TokenValidator {
  const TokenValidator._();

  /// Returns `true` only when token is a JWT with an expired `exp` claim.
  ///
  /// Non-JWT tokens (or JWTs without `exp`) are treated as not expired so
  /// persisted sessions are not invalidated at app startup.
  static bool isExpired(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return false;

      final payloadJson = utf8.decode(
        base64Url.decode(base64Url.normalize(parts[1])),
      );
      final payload = jsonDecode(payloadJson) as Map<String, dynamic>;
      final exp = payload['exp'];
      if (exp is! num) return false;

      final nowInSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      return exp.toInt() <= nowInSeconds;
    } catch (_) {
      return false;
    }
  }
}
