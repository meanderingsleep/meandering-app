import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

Map<String, String> bucketAndPathFromUrl(String url) {
  final List<String> parts = url.split('/');
  String bucket = parts[2].split('.')[0];
  String path = parts[3];
  return {
    'bucket': bucket,
    'path': path,
  };
}

Map<String, String> createAWSHTTPAuthHeaders(String key, String secret, String bucket, String path, String method) {
  final now = DateTime.now().toUtc();
  String formattedDate = DateFormat('E, d MMM yyyy HH:mm:ss').format(now) + " +0000";
  String stringToSign = "$method\n\n\n$formattedDate\n/$bucket/$path";
  var bytes = utf8.encode(stringToSign);

  var hmacSha256 = Hmac(sha1, utf8.encode(secret));
  String signature = base64.encode(hmacSha256.convert(bytes).bytes);
  String authorization = 'AWS ' + key +':$signature';

  Map<String, String> requestHeaders = {
    'Date': formattedDate,
    'Authorization': authorization,
  };
  return requestHeaders;
}